//
//  MaarvelTableViewCell.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 09/01/23.
//

import UIKit

class MarvelTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identidier = "MarvelTableViewCell"
    
    // MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - UISetup Methods
    func uiSetup(collectionView: UICollectionView){
        contentView.addSubview(collectionView)
        collectionView.constrainEdges(to: contentView.safeAreaLayoutGuide)
    }

}
