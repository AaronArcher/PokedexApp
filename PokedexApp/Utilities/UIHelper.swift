//
//  UIHelper.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 02/01/2023.
//

import UIKit

enum UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    static func setCellBackgroundColor(types: String) -> UIColor {
        if types.contains("Grass") {
            return .green.withAlphaComponent(0.15)
        } else if types.contains("Fire") {
            return.red.withAlphaComponent(0.15)
        } else if types.contains("Water") {
            return .blue.withAlphaComponent(0.15)
        } else if types.contains("Electric") {
            return .yellow.withAlphaComponent(0.15)
        } else if types.contains("Poison") {
            return .purple.withAlphaComponent(0.15)
        } else if types.contains("Ground") {
            return .brown.withAlphaComponent(0.15)
        } else if types.contains("Psychic") {
            return .cyan.withAlphaComponent(0.15)
        } else if types.contains("Fairy") {
            return .systemPink.withAlphaComponent(0.15)
        } else {
            return .lightGray.withAlphaComponent(0.15)
        }
    }
    
}
