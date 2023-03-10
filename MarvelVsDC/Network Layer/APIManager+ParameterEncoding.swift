//
//  APIManager+ParameterEncoding.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Alamofire

extension String: ParameterEncoding {
    
    // MARK: Public Methods
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}
