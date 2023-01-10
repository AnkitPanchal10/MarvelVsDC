//
//  MarvelCollectionViewCell.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 09/01/23.
//

import UIKit
import AlamofireImage
import CoreMotion

class MarvelCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    static let identidier = "MarvelCollectionViewCell"
    
    // MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        uiSetUp()
    }
    
    
    // MARK: - SetupUI
    func uiSetUp() {
        comicImage.contentMode = ContentMode.scaleAspectFill
        comicImage.applyDropShadow(shadowColor: .gray, shadowOffset: CGSize.zero, cornerRadius: 10, shadowOpacity: 1, shadowRadius: 10)
        comicImage.clipsToBounds = true
        comicImage.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.darkGray.cgColor
        containerView.layer.cornerRadius = 10
    }
    
    /// Sets data to UI
    func configure(item: Comic){
        lblTitle.text = item.name
        lblLike.text = String(describing: item.likeCount)
        guard let imgUrl = URL(string: item.imageURL), let placeholderImage = UIImage(named: "placeholder") else {
            return
        }
        comicImage.af.setImage(withURL: imgUrl, placeholderImage: placeholderImage)
    }
    
}
