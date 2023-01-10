//
//  APIManager+Interceptor.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import UIKit
import Alamofire

class APIManagerInterceptor: RequestInterceptor {
    
    // MARK: Vars & Lets
    
    var numberOfRetries = 0
    var refreshTokenViewModel = RefreshTokenViewModel()
    
    // MARK: Request Retrier method
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if (error.localizedDescription == "The operation couldn’t be completed. Software caused connection abort") {
            completion(.retryWithDelay(1))
            self.numberOfRetries += 1
        } else if let response = request.task?.response as? HTTPURLResponse, response.statusCode >= 500, self.numberOfRetries < 3 {
            completion(.retryWithDelay(1)) // retry after 1 second
            self.numberOfRetries += 1
        } else if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401, self.numberOfRetries < 3 {
            let reqURL = request.task?.currentRequest?.url?.absoluteString ?? ""
            refreshTokenViewModel.isSuccess.bind { (isSuccess) in
                if isSuccess {
                    completion(.retryWithDelay(1))
                } else {
                    completion(.doNotRetry)
                }
            }
            if userManager.isUserLogin && !(reqURL.contains(RequestItemsType.refreshToken.path)) {
                refreshTokenViewModel.callRefreshToken()
                self.numberOfRetries += 1
            } else {
                completion(.doNotRetry)
            }
             // retry after 2 second, mean while token will be updated from backend
        } else {
            completion(.doNotRetry) // don't retry
            self.numberOfRetries = 0
        }
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var newRequest = urlRequest
        newRequest.setValue("Bearer \(userManager.accessToken)", forHTTPHeaderField: APIParams.Authentication.authorization)
        completion(.success(newRequest))
    }
    
}
