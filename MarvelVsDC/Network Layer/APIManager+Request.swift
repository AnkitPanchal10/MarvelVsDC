//
//  APIManager+Request.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Alamofire

// MARK: Enums

enum RequestItemsType {
    case refreshToken
    case comicList

}

// MARK: Extensions
// MARK: EndPointType

extension RequestItemsType: EndPointType {

    // MARK: Vars & Lets
    
    var baseURL: String {
        return AppConstant.serverURL
    }
    
    var version: String {
        return ""
    }
    
    var path: String {
        switch self {
        case .refreshToken:
            return "refreshToken"
        case .comicList:
            return "superheroes"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .refreshToken:
            return .post
        case .comicList:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return userManager.httpTokenHeader
        }
    }
    
    var url: URL {
        switch self {
        case .refreshToken, .comicList:
            return URL(string: self.baseURL + self.version +  self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}
