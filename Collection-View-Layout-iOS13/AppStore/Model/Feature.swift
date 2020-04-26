//
//  Feature.swift
//  Collection-View-Layout-iOS13
//
//  Created by atikhonov on 26.04.2020.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import UIKit

struct Feature {
    var title: String
    var imageName: String
    var size: CGSize
}

extension Feature {
    static func testData() -> [Feature] {
        let feature1 = Feature(title: "airplane", imageName: "airplane", size: .random())
        let feature2 = Feature(title: "bebo", imageName: "bebo", size: .random())
        let feature3 = Feature(title: "google plus", imageName: "google-plus", size: .random())
        let feature4 = Feature(title: "blackberry", imageName: "blackberry", size: .random())
        let feature5 = Feature(title: "react native", imageName: "react-native", size: .random())
        let feature6 = Feature(title: "pocket", imageName: "pocket", size: .random())
        let feature7 = Feature(title: "airplane", imageName: "airplane", size: .random())
        let feature8 = Feature(title: "bebo", imageName: "bebo", size: .random())
        let feature9 = Feature(title: "google plus", imageName: "google-plus", size: .random())
        let feature10 = Feature(title: "blackberry", imageName: "blackberry", size: .random())
        let feature11 = Feature(title: "react native", imageName: "react-native", size: .random())
        let feature12 = Feature(title: "pocket", imageName: "pocket", size: .random())
        return [feature1, feature2, feature3, feature4, feature5, feature6, feature7, feature8, feature9, feature10, feature11, feature12]
    }
}

private extension CGSize {
    static func random() -> Self {
        let array = [CGSize(width: 150.0, height: 150.0), CGSize(width: 316.0, height: 150.0)]
        let index = Int.random(in: 0...1)
        return array[index]
    }
}
