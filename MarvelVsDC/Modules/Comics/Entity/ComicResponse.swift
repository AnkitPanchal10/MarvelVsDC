//
//  responseModel.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//
//   let comicResponse = try? JSONDecoder().decode(ComicResponse.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseComicResponse { response in
//     if let comicResponse = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - ComicResponse
struct ComicResponse: Codable {
    let marvel, dc: [Comic]
}


// MARK: - Comic
struct Comic: Codable {
    let name: String
    let likeCount: Int
    let imageURL: String
    let isLeader: Bool?

    enum CodingKeys: String, CodingKey {
        case name, likeCount
        case imageURL = "image_url"
        case isLeader = "is_leader"
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

