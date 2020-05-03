//
//  ActivateCollectionViewCell.swift
//  Collection-View-Layout-iOS13
//
//  Created by Tikhonov, Aleksandr on 03.05.20.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import UIKit

class ActivateCollectionViewCell: UICollectionViewCell {

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var chevronImageView: UIImageView!
    
    static let reuseIdentifier = "ActivateCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
    }

}
