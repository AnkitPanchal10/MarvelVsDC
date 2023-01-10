//
//  APIManagerMock.swift
//  MarvelVsDCTests
//
//  Created by Ankit Panchal on 09/01/23.
//

import XCTest
import Alamofire

@testable import MarvelVsDC

class APIManagerMock: APIManager {
    var expectedJsonData: Data?
    
    
    override func call<T>(type: RequestItemsType, params: Parameters? = nil, handler: @escaping (Result<T, CustomError>) -> Void) where T : Decodable, T : Encodable {
        if let jsonData = expectedJsonData {
            if let parsedData = getDecodableItemFromData(jsonData, type: T.self){
                handler(.success(parsedData))
            } else {
                handler(.failure(MokError.genericError))
            }
        } else {
            handler(.failure(MokError.genericError))
        }
    }
    
    private func getDecodableItemFromData<T: Decodable>(_ data: Data, type: T.Type) -> T? {
        let devcodedObject = try? JSONDecoder().decode(type, from: data)
        return devcodedObject
    }
    
}
