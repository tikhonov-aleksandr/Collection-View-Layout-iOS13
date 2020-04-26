//
//  FeatureCell.swift
//  Collection-View-Layout-iOS13
//
//  Created by atikhonov on 26.04.2020.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import UIKit

class FeatureCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    static let reuseIdentifier = "FeatureCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6.0
    }
    
    func configure(with title: String, image: UIImage?) {
        titleLabel.text = title.capitalized
        imageView.image = image
    }
}
