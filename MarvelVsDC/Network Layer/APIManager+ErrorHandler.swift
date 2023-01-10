//
//  APIManager+ErrorHandeling.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import UIKit
import Alamofire

struct APIParams {
    
    struct Authentication {
        static let refreshToken = "refreshToken"
        static let contentType = "Content-Type"
        static let authorization = "Authorization"
        static let email = "email"
        static let password = "password"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let confirmPassword = "confirmPassword"
        static let signUpType = "signup_type"
        static let socialId = "social_id"
    }
    
}

/// API Error
struct APIError {

    // MARK: Alerts
    static let defaultAlertTitle   = "warning"
    static let errorAlertTitle     = "error"
    static let genericErrorMessage = "Something went wrong, please try again."
    static let unprocessableEntity = "Unprocessable Entity"
    static let notFound            = "Not Found"
    static let parameterMissing    = "Missing Param"
    static let unAuthorizeUser     = "Authorisation Error"
    static let noInternet          = "No Internet Connection"
    static let noData              = "No data"
}

extension APIManager {
    
    func parseApiError(dataResponse: AFDataResponse<Data>?) -> CustomError {
        guard let data = dataResponse else {
            return CustomError(title: APIError.errorAlertTitle, body: APIError.genericErrorMessage)
        }
        let decoder = JSONDecoder()
        if let jsonData = data.data, let error = try? decoder.decode(NetworkError.self, from: jsonData) {
             return CustomError(title: APIError.errorAlertTitle, body: error.message)
        }
        if let statusCode = data.response?.statusCode {
           return parseHTTPStatusCodeErrors(statusCode: statusCode)
        } else {
            return CustomError(title: APIError.errorAlertTitle, body: APIError.noInternet)
        }
    }

    func parseHTTPStatusCodeErrors(statusCode: Int) -> CustomError {
        if APIManager.errorCodeList.contains(statusCode) {
            if statusCode == 422 { // Unprocessable Entity
                return CustomError(title: APIError.errorAlertTitle, body: APIError.unprocessableEntity)
            } else if statusCode == 404 { // not found
                return CustomError(title: APIError.errorAlertTitle, body: APIError.notFound)
            } else if statusCode == 400 { // paramter required error
                return CustomError(title: APIError.errorAlertTitle, body: APIError.parameterMissing)
            } else if statusCode == 403 { // forbidden
                return CustomError(title: APIError.errorAlertTitle, body: APIError.unAuthorizeUser)
            } else if statusCode == 401 { // unauthorised
                return CustomError(title: APIError.errorAlertTitle, body: APIError.unAuthorizeUser)
            }
        } else if statusCode == -1009 || statusCode == -1001 || statusCode == -1003 {
            // No Internet
            return CustomError(title: APIError.errorAlertTitle, body: APIError.noInternet)
        } else if statusCode == 500 { // Something went Wrong
            return CustomError(title: APIError.errorAlertTitle, body: APIError.genericErrorMessage)
        }
        return CustomError(title: APIError.errorAlertTitle, body: APIError.genericErrorMessage)
    }
    
}
