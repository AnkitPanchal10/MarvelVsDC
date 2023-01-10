//
//  ViewModelProtocol.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Foundation
import Alamofire

typealias StatusHandler = (Bool) -> Void
typealias StatusAndErrorHandler = (Bool, CustomError?) -> Void

protocol ComicProtocol {
    
    /// Get commic list from server
    ///
    /// - Parameter completion: Give the success or failute status
    func requestComicsAPI(_ completion: @escaping StatusHandler)
    
    ///  Get number of section in table
    ///
    /// - Returns: Number of section in table
    func numberOfSectionsInTable() -> Int
    
    /// Get number of row in a section
    ///
    /// - Parameter section: section value
    /// - Returns: Number of row in section
    func numberOfRows(in section: Int) -> Int
    
    
    /// Get number of section in collection
    ///
    ///
    /// - Parameters:
    ///     - subject: The subject to be welcomed.
    ///
    /// - Returns: Return the number of section in collection
    func numberOfSectionsInCollection() -> Int
    
    /// Get the number of items in section
    ///
    /// - Parameter section: section value
    /// - Returns: Return the number of rows
    ///
    ///
    func numberOfItemsInSection (section: Int) -> Int
    
    /// Get the comic item based on the section
    ///  for horizontal scroll it returns Marvel comic item and for vertical scroll it  returns DC comic item
    ///
    /// - Parameter indexPath: indexPath which contain both seciton value and row value
    /// - Returns: Return the `Comic` object
    func getComicItem(at indexPath: IndexPath) -> Comic?
    
    /// Get section Type
    /// - Parameter section: section value
    /// - Returns: TableVIewSection enum with type
    func getSection(section: Int) -> TableViewSection
}

