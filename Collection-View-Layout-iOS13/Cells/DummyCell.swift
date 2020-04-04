//
//  DummyCell.swift
//  Collection-View-Layout-iOS13
//
//  Created by atikhonov on 02.04.2020.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import UIKit

class DummyCell: UICollectionViewCell {
    
    @IBOutlet var textLabel: UILabel!
    
    static let reuseIdentifier = "DummyCell"
    
    func configure(with text: String) {
        textLabel.text = "\(text)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
    }

}
