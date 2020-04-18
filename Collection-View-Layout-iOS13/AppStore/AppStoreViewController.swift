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
            let section = self.layoutSection(for: sectionKind)
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16.0
        let layout = UICollectionViewCompositionalLayout.init(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        let nib = UINib(nibName: DummyCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: DummyCell.reuseIdentifier)
        let nib2 = UINib(nibName: BannerCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib2, forCellWithReuseIdentifier: BannerCell.reuseIdentifier)
        let nib3 = UINib(nibName: AppCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib3, forCellWithReuseIdentifier: AppCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
    private lazy var bannerRange: ClosedRange<Int> = 1...self.banners.count
    private lazy var appsRange: ClosedRange<Int> = (self.banners.count + 1)...(self.banners.count + self.apps.count)
    private lazy var categoryRange: ClosedRange<Int> = 41...46
    
    private var banners: [Banner] = Banner.testData()
    private var apps: [App] = App.testData()
    
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
                cell.configure(with: app.title, subtitle: app.subtitle, image: UIImage(named: app.imageName))
                
                return cell
            }
            
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DummyCell.reuseIdentifier, for: indexPath) as? DummyCell else { fatalError("Cannot create the cell") }
            
            cell.textLabel.text = "\(identifier)"
            
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        let sections: [Section] = [.banner, .apps, .category]
        snapshot.appendSections([sections[0]])
        snapshot.appendItems(Array(bannerRange))
        snapshot.appendSections([sections[1]])
        snapshot.appendItems(Array(appsRange))
        snapshot.appendSections([sections[2]])
        snapshot.appendItems(Array(categoryRange))

        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func layoutSection(for section: Section) -> NSCollectionLayoutSection {
        switch section {
        case .banner:
            return bannerSection()
        case .apps:
            return appsSection()
        case .category:
            return categorySection()
        }
    }
    
    private func bannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func appsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0/3.0)) // height is ignored
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3) // <<<===
        group.interItemSpacing = .fixed(16.0)
        
        let rootGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .absolute(200))
        let rootGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rootGroupSize, subitems: [group])
        let section = NSCollectionLayoutSection(group: rootGroup)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func categorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0/3.0)) // height is ignored
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // width is ignored
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3) // <<<===
        group.interItemSpacing = .fixed(16.0)
        
        let rootGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let rootGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rootGroupSize, subitem: group, count: 2) // <<<===
        rootGroup.interItemSpacing = .fixed(16.0)
        let section = NSCollectionLayoutSection(group: rootGroup)
        return section
    }
}
