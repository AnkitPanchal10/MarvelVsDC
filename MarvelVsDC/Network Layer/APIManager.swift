//
//  APIManager.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Alamofire
import UIKit

class APIManager: NetworkManger {
    
    
    // MARK: Vars & Lets
    let reachability = try? Reachability()
    private let sessionManager: Session
    private let interceptor: APIManagerInterceptor
    static let errorCodeList =  [400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 421, 422, 423, 424, 425, 426, 427, 428, 429, 431, 451, 500, -1009, -1001]
    let imageCache = NSCache<NSString, UIImage>()
    
    func call(type: RequestItemsType, params: Parameters?, handler: @escaping (Swift.Result<(), CustomError>) -> Void) {
        guard reachability?.connection ?? .unavailable != .unavailable else {
            handler(.failure(CustomError(title: "MarvelVsDC", body: APIError.noInternet)))
            return
        }
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseData { (data) in
            if self.handleResponseCode(res: data) {
                switch data.result {
                case .success:
                    handler(.success(()))
                case .failure:
                    handler(.failure(self.parseApiError(dataResponse: data)))
                }
            } else {
                handler(.failure(self.parseApiError(dataResponse: data)))
            }
        }
    }
    
    func call<T>(type: RequestItemsType, params: Alamofire.Parameters? = nil, handler: @escaping (Result<T, CustomError>) -> Void) where T : Codable {
        guard reachability?.connection ?? .unavailable != .unavailable else {
            handler(.failure(CustomError(title: "MarvelVsDC", body: APIError.noInternet)))
            return
        }
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseData { (data) in
            if self.handleResponseCode(res: data) {
                do {
                    guard let jsonData = data.data else {
                        throw CustomError(title: APIError.defaultAlertTitle, body: APIError.noData)
                    }
                    ///TODO: Use BaseModel for proper response structure
                    let result = try JSONDecoder().decode(T.self, from: jsonData)
                    handler(.success(result))
                    self.resetNumberOfRetries()
                } catch {
                    if let error = error as? CustomError {
                        return handler(.failure(error))
                    }
                    handler(.failure(self.parseApiError(dataResponse: data)))
                }
            } else {
                handler(.failure(self.parseApiError(dataResponse: data)))
            }
        }

    }
    
    // MARK: Private methods
    
    private func resetNumberOfRetries() {
        self.interceptor.numberOfRetries = 0
    }
    
    /// Handle response code
    ///
    /// - Parameter res: api response
    /// - Returns: returns true if response status is sucess else false
    private func handleResponseCode(res: AFDataResponse<Data>?) -> Bool {
        var isSuccess: Bool = false
        
        guard let dataResponse = res else {
            return isSuccess
        }
        guard let response = dataResponse.response else {
            return isSuccess
        }
        
        switch response.statusCode {
        case 200...300:
            isSuccess = true
        default: break
        }
        
        return isSuccess
    }
    
    // MARK: Initialization
    
    init(interceptor: APIManagerInterceptor) {
        self.interceptor = interceptor
        self.sessionManager = Session(interceptor: interceptor)
    }
    
}
