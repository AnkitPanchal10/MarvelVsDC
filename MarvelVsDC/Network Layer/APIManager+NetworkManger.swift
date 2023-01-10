//
//  APIManager+NetworkManger.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Alamofire
import UIKit

/// Network Manger call the register data provide calls data provider methods
protocol NetworkManger {
    
    ///  Send request to network
    /// - Parameters:
    ///   - type: set the API call end point using enum `RequestItemsType`
    ///   - params: API requesst body data
    ///   - handler:  Return a call back with success or failure status, wtith response model in case of success 
    ///
    func call<T>(type: RequestItemsType, params: Parameters?, handler: @escaping (Swift.Result<T, CustomError>) -> Void) where T: Codable
}
