//
//  ComicTableViewCell.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import UIKit
import AlamofireImage

class ComicTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var comicImage: UIImageView!
    static let identidier = "ComicTableViewCell"
    
    // MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        uiSetUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
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
        lblLikes.text = String(describing: item.likeCount)
        guard let imgUrl = URL(string: item.imageURL), let placeholderImage = UIImage(named: "placeholder") else {
            return
        }
        comicImage.af.setImage(withURL: imgUrl, placeholderImage: placeholderImage)
        
    
    }

}
