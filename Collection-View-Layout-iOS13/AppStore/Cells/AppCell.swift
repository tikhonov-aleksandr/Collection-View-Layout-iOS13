//
//  AppCell.swift
//  Collection-View-Layout-iOS13
//
//  Created by atikhonov on 18.04.2020.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import UIKit

class AppCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var getButton: UIButton!
    @IBOutlet var separatorView: UIView!
    
    static let reuseIdentifier = "AppCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getButton.layer.masksToBounds = true
        getButton.layer.cornerRadius = 5.0
    }
    
    func configure(with title: String, subtitle: String, image: UIImage?, isSeparatorHidden: Bool) {
        titleLabel.text = title.capitalized
        subtitleLabel.text = subtitle.capitalized
        imageView.image = image
        separatorView.isHidden = isSeparatorHidden
    }
    
}
