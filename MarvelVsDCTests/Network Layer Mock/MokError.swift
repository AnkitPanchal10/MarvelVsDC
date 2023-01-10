//
//  MokError.swift
//  MarvelVsDCTests
//
//  Created by Ankit Panchal on 09/01/23.
//

@testable import MarvelVsDC

class MokError: CustomError {
    static let genericError = CustomError(title: "Mock error", body: "Mock error description")
}
