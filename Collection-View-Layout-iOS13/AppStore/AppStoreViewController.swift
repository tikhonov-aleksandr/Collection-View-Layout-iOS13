//
//  AppStoreViewController.swift
//  Collection-View-Layout-iOS13
//
//  Created by Tikhonov, Aleksandr on 16.04.20.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import UIKit

class AppStoreViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case banner
        case apps
        case category
        case feature
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "App Store"
        configureHierarchy()
        configureDataSource()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let section = self.layoutSection(for: sectionKind, layoutEnvironment: layoutEnvironment)
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16.0
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        let nib1 = UINib(nibName: BannerCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib1, forCellWithReuseIdentifier: BannerCell.reuseIdentifier)
        let nib2 = UINib(nibName: AppCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib2, forCellWithReuseIdentifier: AppCell.reuseIdentifier)
        let nib3 = UINib(nibName: CategoryCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib3, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        let nib4 = UINib(nibName: FeatureCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib4, forCellWithReuseIdentifier: FeatureCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
    private lazy var bannerRange: ClosedRange<Int> = 1...banners.count
    private lazy var appsRange: ClosedRange<Int> = (bannerRange.upperBound + 1)...(bannerRange.upperBound + apps.count)
    private lazy var categoryRange: ClosedRange<Int> = (appsRange.upperBound + 1)...(appsRange.upperBound + categories.count)
    private lazy var featureRange: ClosedRange<Int> = (categoryRange.upperBound + 1)...(categoryRange.upperBound + features.count)
    
    private var banners: [Banner] = Banner.testData()
    private var apps: [App] = App.testData()
    private var categories: [Category] = Category.testData()
    private var features: [Feature] = Feature.testData()
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            if self.bannerRange ~= identifier {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseIdentifier, for: indexPath) as? BannerCell else { fatalError("Cannot create the cell") }
                let banner = self.banners[indexPath.row]
                cell.configure(with: banner.title, subtitle: banner.subtitle, image: UIImage(named: banner.imageName))
                return cell
            }
            
            if self.appsRange ~= identifier {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCell.reuseIdentifier, for: indexPath) as? AppCell else { fatalError("Cannot create the cell") }
                let app = self.apps[indexPath.row]
                let isSeparatorHidden = (identifier - self.appsRange.lowerBound + 1).isMultiple(of: 3)
                cell.configure(with: app.title, subtitle: app.subtitle, image: UIImage(named: app.imageName), isSeparatorHidden: isSeparatorHidden)
                return cell
            }
            
            if self.categoryRange ~= identifier {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else { fatalError("Cannot create the cell") }
                let category = self.categories[indexPath.row]
                let isSeparatorHidden = (identifier - self.categoryRange.lowerBound + 1).isMultiple(of: 3)
                cell.configure(with: category.title, image: UIImage(named: category.imageName), isSeparatorHidden: isSeparatorHidden)
                return cell
            }
            
            if self.featureRange ~= identifier {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCell.reuseIdentifier, for: indexPath) as? FeatureCell else { fatalError("Cannot create the cell") }
                let feature = self.features[indexPath.row]
                cell.configure(with: feature.title, image: UIImage(named: feature.imageName))
                return cell
            }
            
            fatalError("Cannot create the cell")
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        let sections: [Section] = [.banner, .apps, .category, .feature]
        snapshot.appendSections([sections[0]])
        snapshot.appendItems(Array(bannerRange))
        snapshot.appendSections([sections[1]])
        snapshot.appendItems(Array(appsRange))
        snapshot.appendSections([sections[2]])
        snapshot.appendItems(Array(categoryRange))
        snapshot.appendSections([sections[3]])
        snapshot.appendItems(Array(featureRange))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func layoutSection(for section: Section, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch section {
        case .banner:
            return bannerSection()
        case .apps:
            return appsSection()
        case .category:
            return categorySection()
        case .feature:
            return featureSection(layoutEnvironment: layoutEnvironment)
        }
    }
    
    private func bannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func appsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0/3.0)) // height is ignored
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3) // <<<===
        group.interItemSpacing = .fixed(2.0)
        
        let rootGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .absolute(220))
        let rootGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rootGroupSize, subitems: [group])
        let section = NSCollectionLayoutSection(group: rootGroup)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func categorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0/3.0)) // height is ignored
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // width is ignored
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3) // <<<===
        group.interItemSpacing = .fixed(8.0)
        
        let rootGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180))
        let rootGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rootGroupSize, subitem: group, count: 2) // <<<===
        rootGroup.interItemSpacing = .fixed(8.0)
        let section = NSCollectionLayoutSection(group: rootGroup)
        return section
    }
    
    private func featureSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let feature = FeatureLayoutSection(containerWidth: layoutEnvironment.container.contentSize.width)
        feature.delegate = self
        if let section = feature.collectionLayoutSection() {
            return section
        } else {
            fatalError("Cannot create Feature section")
        }
    }
}

extension AppStoreViewController: FeatureLayoutSectionDelegate {
    func sizes(for featureLayout: FeatureLayoutSection) -> [CGSize] {
        features.map { $0.size }
    }
    
    func itemSpacing(for featureLayout: FeatureLayoutSection) -> CGFloat {
        16.0
    }
    
    func rowSpacing(for featureLayout: FeatureLayoutSection) -> CGFloat {
        16.0
    }
    
    func minimalSectionInset(for featureLayout: FeatureLayoutSection) -> CGFloat {
        16.0
    }
}
