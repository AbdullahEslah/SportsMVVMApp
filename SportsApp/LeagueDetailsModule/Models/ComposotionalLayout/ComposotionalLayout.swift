//
//  ComposotionalLayout.swift
//  SportsApp
//
//  Created by Macbook on 14/06/2022.
//

import Foundation
import UIKit

class ComposotionalLayout {
    
    func createcompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self](index, enviroment) -> NSCollectionLayoutSection? in
            
            return self?.createSectionFor(index: index, enviroment: enviroment)
        }
        return layout
    }
    
    
    func createSectionFor(index:Int , enviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        switch index {
        
        case 0:
            return createSecoendSection()

        case 1:
            return createList()
            
        case 2:
            return createCustom()
            
        default:
            return createSecoendSection()
            
        }
    }
    
    
    func createSecoendSection() -> NSCollectionLayoutSection {
        let inset: CGFloat = 2.5
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: Constants.sectionHeaderElementKind, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func createCustom() -> NSCollectionLayoutSection  {
        
        let fraction: CGFloat = 1.0 / 3.0
            
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalWidth(fraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 2.5, bottom: 0, trailing: 2.5)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.7
                let maxScale: CGFloat = 1.1
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
                
               
            }
          
    }
       
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 - 0.5), heightDimension: .absolute(30))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: Constants.sectionHeaderElementKind, alignment: .topLeading)
        
        section.boundarySupplementaryItems = [header]
        
        return section
}
    
    func createFirstSection() -> NSCollectionLayoutSection {
        
        // Define Item Size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150.0))
        
        // Create Item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 8, bottom: 53, trailing: 3)
        
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,
                                                       subitem: item,
                                                       count: 1)
        
        //header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        // Create Section
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let headerLeading = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: Constants.sectionHeaderElementKind, alignment: .topLeading)
        
        section.boundarySupplementaryItems = [headerLeading]
        
        
        return section
    }
    
    
    func createList() -> NSCollectionLayoutSection {

        let estimatedHeight = CGFloat(150)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,
                                                       subitem: item,
                                                       count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: Constants.sectionHeaderElementKind, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        return section
     
    }
}
