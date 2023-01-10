//
//  ComicScreenBuilder.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//


import UIKit.UINavigationController

struct ComicScreenBuilder {
    static func build(
        with navigationController: UINavigationController?, networkManager: APIManager) -> ComicViewController {
        // Building
        let viewModel = ComicViewModel(networkManager: networkManager)
        let view = ComicViewController(viewModel: viewModel)
        return view
    }
}
