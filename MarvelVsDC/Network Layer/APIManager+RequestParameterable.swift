//
//  APIManager+RequestParameterable.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Foundation

protocol RequestParameterable {
    var requestParams: [String: Any]? { get }
}

extension RequestParameterable where Self: Encodable {
    
    var requestParams: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let params = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        /*
         if let jsonString = String(data: data, encoding: .utf8) {
         print(jsonString)
         }
         */
        return params
    }
}

extension Array where Element: Encodable {
    
    var requestParams: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let params = try? JSONSerialization.jsonObject(with: data) as? [Any] else {
            return nil
        }
        /*
         if let jsonString = String(data: data, encoding: .utf8) {
         print(jsonString)
         }
         */
        return ["arrayParametersKey": params]
    }
}
