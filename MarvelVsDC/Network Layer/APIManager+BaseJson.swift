//
//  APIManager+BaseJson.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Foundation

/// This is base json model of codable type
/// In throught app response base model will be same.
class BaseJsonModel<T: Codable>: Codable {
    let status: Bool
    let data: T
}
