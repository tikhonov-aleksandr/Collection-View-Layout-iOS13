//
//  FeatureLayout.swift
//  Collection-View-Layout-iOS13
//
//  Created by Tikhonov, Aleksandr on 26.04.20.
//  Copyright © 2020 atikhonov. All rights reserved.
//


import UIKit

protocol FeatureLayoutSectionDelegate: AnyObject {
    func sizes(for featureLayout: FeatureLayoutSection) -> [CGSize]
    func itemSpacing(for featureLayout: FeatureLayoutSection) -> CGFloat
    func rowSpacing(for featureLayout: FeatureLayoutSection) -> CGFloat
    func minimalSectionInset(for featureLayout: FeatureLayoutSection) -> CGFloat
}

final class FeatureLayoutSection {
    
    weak var delegate: FeatureLayoutSectionDelegate?
    
    var containerWidth: CGFloat
    
    init(containerWidth: CGFloat) {
        self.containerWidth = containerWidth
    }
    
    // this layout works for ipad and iphones, but doesn't work with iphones with small screens
    func collectionLayoutSection() -> NSCollectionLayoutSection? {
        
        guard let delegate = self.delegate else { return nil }
        
        let sizes = delegate.sizes(for: self)
        guard let groupHeight: CGFloat = sizes.max(by: { $0.height < $1.height })?.height else { return nil }
        
        let minimalSectionInset: CGFloat = delegate.minimalSectionInset(for: self)
        let leftAndRightInset: CGFloat = 2.0 * minimalSectionInset
        let itemSpacing: CGFloat = delegate.itemSpacing(for: self)
        let availableWidth: CGFloat = containerWidth - leftAndRightInset
        var actualWidth: CGFloat = 0.0
        
        let vericalSubitems = self.vericalGroups(sizes: sizes, itemSpacing: itemSpacing, availableWidth: availableWidth, actualWidth: &actualWidth, groupHeight: groupHeight)
        
        let groupSpacing: CGFloat = delegate.rowSpacing(for: self)
        let rootGroupHeight: CGFloat = groupHeight * CGFloat(vericalSubitems.count) + CGFloat(vericalSubitems.count - 1) * groupSpacing
        let rootGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(actualWidth), heightDimension: .absolute(rootGroupHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: rootGroupSize, subitems: vericalSubitems)
        group.edgeSpacing = .init(leading: .flexible(minimalSectionInset), top: .fixed(minimalSectionInset), trailing: .flexible(minimalSectionInset), bottom: .fixed(minimalSectionInset))
        group.interItemSpacing = .fixed(groupSpacing)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func vericalGroups(sizes: [CGSize], itemSpacing: CGFloat, availableWidth: CGFloat, actualWidth: inout CGFloat, groupHeight: CGFloat) -> [NSCollectionLayoutItem] {
        
        var copySizes: [CGSize] = sizes.reversed()
        
        var currentSubitems: [NSCollectionLayoutItem] = []
        var vericalSubitems: [NSCollectionLayoutItem] = []
        var currentWidth: CGFloat = 0.0
        
        while !copySizes.isEmpty || !currentSubitems.isEmpty {
            if let size = copySizes.last {
                let additionalWidth: CGFloat = currentSubitems.isEmpty ? size.width : itemSpacing + size.width
                if  currentWidth + additionalWidth <= availableWidth {
                    let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(size.width), heightDimension: .fractionalHeight(1.0))
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    currentSubitems.append(item)
                    currentWidth += additionalWidth
                    copySizes.removeLast()
                    continue
                }
            }
            actualWidth = max(actualWidth, currentWidth)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize:
                NSCollectionLayoutSize(widthDimension: .absolute(currentWidth), heightDimension: .absolute(groupHeight)),
                                                                     subitems: currentSubitems)
            horizontalGroup.interItemSpacing = .fixed(itemSpacing)
            vericalSubitems.append(horizontalGroup)
            currentSubitems.removeAll()
            currentWidth = 0.0
        }
        
        return vericalSubitems
    }
}



