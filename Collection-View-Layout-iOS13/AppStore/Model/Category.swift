//
//  Category.swift
//  Collection-View-Layout-iOS13
//
//  Created by atikhonov on 26.04.2020.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import Foundation

struct Category {
    var title: String
    var imageName: String
}

extension Category {
    static func testData() -> [Category] {
        let category1 = Category(title: "airplane", imageName: "airplane")
        let category2 = Category(title: "bebo", imageName: "bebo")
        let category3 = Category(title: "google plus", imageName: "google-plus")
        let category4 = Category(title: "blackberry", imageName: "blackberry")
        let category5 = Category(title: "react native", imageName: "react-native")
        let category6 = Category(title: "pocket", imageName: "pocket")
        return [category1, category2, category3, category4, category5, category6]
    }
}
