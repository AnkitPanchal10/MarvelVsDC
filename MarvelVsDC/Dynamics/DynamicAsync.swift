//
//  DynamicAsync.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Foundation

class DynamicAsync<T>: Dynamic<T> {

    // MARK: Ovverides

    override func fire() {
        self.listener?(self.value)
        // -->{ self.listener?(self.value) }
    }

    // MARK: Initialization

    override init(_ v: T) {
        super.init(v)
    }
}
