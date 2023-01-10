//
//  MockJson.swift
//  MarvelVsDCTests
//
//  Created by Ankit Panchal on 09/01/23.
//

import XCTest
@testable import MarvelVsDC

public enum MockJson {
    case comicListSuccessResponse
    
    var url: URL? {
        let testBundle = Bundle(for: APIManagerMock.self)
        switch self {
        case .comicListSuccessResponse:
            return testBundle.url(forResource: "ComicListSuccessResponse", withExtension: ".json")
        }
    }
    
    func getJsonData() -> Data? {
        guard let url = self.url else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
