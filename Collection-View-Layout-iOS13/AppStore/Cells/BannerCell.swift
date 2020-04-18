//
//  BannerCell.swift
//  Collection-View-Layout-iOS13
//
//  Created by atikhonov on 18.04.2020.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {

    @IBOutlet var linkLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    static let reuseIdentifier = "BannerCell"
    
    func configure(with title: String, subtitle: String, image: UIImage?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        imageView.image = image
        linkLabel.text = randomLink()
    }
    
    private func randomLink() -> String {
        ["Learn something new", "Watch live", "Feature", "Subsrive", "Soon"]
            .map { $0.capitalized }
            .randomElement()!
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 1.0
//    }
}
