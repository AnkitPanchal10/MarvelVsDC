//
//  ViewModel.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Foundation

final class ComicViewModel {
var comicList: ComicResponse?
    let networkManager: APIManager
    
    init(networkManager: APIManager) {
        self.networkManager = networkManager
    }
    
}

// MARK: - ComicViewModelProtocol
extension ComicViewModel: ComicProtocol {
    
    func getSection(section: Int) -> TableViewSection{
        TableViewSection.init(rawValue: section) ?? .marvel
    }
    
    func requestComicsAPI(_ completion: @escaping StatusHandler) {
        networkManager.call(type: .comicList) { [weak self] (result: Swift.Result<ComicResponse, CustomError>) in
            guard let self = self else {
                completion(false)
                return
            }
            switch(result){
            case .success(let data):
                self.comicList = data
                completion(true)
                break;
            case .failure(let error):
                completion(false)
                //TODO: show error message
                print(error)
                break;
            }
        }
        
    }
    
    func numberOfSectionsInTable() -> Int {
        return 2
    }
    
    func numberOfRows(in section: Int) -> Int {
        getSection(section: section) == .marvel ? 1 : comicList?.dc.count ?? 0
    }
    
    func getComicItem(at indexPath: IndexPath) -> Comic? {
        getSection(section: indexPath.section) == .marvel ? comicList?.marvel[indexPath.row] : comicList?.dc[indexPath.row]

    }
    
    func numberOfSectionsInCollection() -> Int {
        return 1
    }
    
    func numberOfItemsInSection (section: Int) -> Int {
        return comicList?.marvel.count ?? 0
    }
}
