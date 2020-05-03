//
//  CardsViewController.swift
//  Collection-View-Layout-iOS13
//
//  Created by Tikhonov, Aleksandr on 03.05.20.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    enum Section: Int {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cards"
        configureHierarchy()
        configureDataSource()
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        let nib1 = UINib(nibName: ActivateCollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib1, forCellWithReuseIdentifier: ActivateCollectionViewCell.reuseIdentifier)
        let nib2 = UINib(nibName: ActionCollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib2, forCellWithReuseIdentifier: ActionCollectionViewCell.reuseIdentifier)
        let nib3 = UINib(nibName: SubmitCollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib3, forCellWithReuseIdentifier: SubmitCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            let c: UICollectionViewCell
            if identifier == 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivateCollectionViewCell.reuseIdentifier, for: indexPath) as? ActivateCollectionViewCell else { fatalError("Cannot create the cell") }
                // cell.titleLabel.text = "Active"
                c = cell
            } else if identifier == 2 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionCollectionViewCell.reuseIdentifier, for: indexPath) as? ActionCollectionViewCell else { fatalError("Cannot create the cell") }
               // cell.titleLabel.text = "Action "
                c = cell
            } else if identifier == 3 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubmitCollectionViewCell.reuseIdentifier, for: indexPath) as? SubmitCollectionViewCell else { fatalError("Cannot create the cell") }
               // cell.titleLabel.text = "Submit"
                c = cell
            } else {
                fatalError()
            }
            
            return c
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(1...3))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension CardsViewController {
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
    
    private func layoutSection(for section: Section, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch section {
        case .main:
            return mainSection()
        }
    }
    
    private func mainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0/3.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let itemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
        let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
        
        let itemSize3 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0/2.0)) // .fractionalWidth(1.0/2.0)
        let item3 = NSCollectionLayoutItem(layoutSize: itemSize3)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item, item2, item3])
//        group.contentInsets = .init(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
        group.interItemSpacing = .fixed(20)
        let section = NSCollectionLayoutSection(group: group)
        // section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
}
