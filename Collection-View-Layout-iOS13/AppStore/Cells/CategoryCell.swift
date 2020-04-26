//
//  CategoryCell.swift
//  Collection-View-Layout-iOS13
//
//  Created by atikhonov on 26.04.2020.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var separatorView: UIView!
    
    static let reuseIdentifier = "CategoryCell"
    
    func configure(with title: String, image: UIImage?, isSeparatorHidden: Bool) {
        titleLabel.text = title.capitalized
        imageView.image = image
        separatorView.isHidden = isSeparatorHidden
    }
}
