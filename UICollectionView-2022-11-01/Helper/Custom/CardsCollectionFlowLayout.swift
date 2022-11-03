//
//  CardsCollectionFlowLayout.swift
//  CollectionView-2022-08-31
//
//  Created by Ly Manny on 31/8/22.
//

import UIKit

class CardsCollectionFlowLayout: UICollectionViewFlowLayout {
    
    private let itemHeight = 150
    private let itemWidth  = 225
    
    // The prepare() method is called to tell the collection view layout object to update the current layout.
    // Layout updates occur the first time the collection view presents its content and whenever the layout is invalidated.
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        scrollDirection = .horizontal
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let peekingItemWidth = itemSize.width / 10
        let horizontalInsets = (collectionView.frame.size.width - itemSize.width) / 2
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: horizontalInsets, bottom: 0, right: horizontalInsets)
        minimumLineSpacing = horizontalInsets - peekingItemWidth
    }
    
}


extension UICollectionView {
    func scaleCells(distanceFromMainPosition: CGFloat, maximumScalingArea: CGFloat, scalingArea: CGFloat) -> [CGFloat] {
        var preferredScale: CGFloat = 0.0
        var preferredAlpha: CGFloat = 0.0
        
        let maxScale = ScaledVisibleCellsCollectionView.sharedInstance.maxScale
        let minScale = ScaledVisibleCellsCollectionView.sharedInstance.minScale
        let maxAlpha = ScaledVisibleCellsCollectionView.sharedInstance.maxAlpha
        let minAlpha = ScaledVisibleCellsCollectionView.sharedInstance.minAlpha
        
        if distanceFromMainPosition < maximumScalingArea {
            // cell in maximum-scaling area
            preferredScale = maxScale
            preferredAlpha = maxAlpha
            
        } else if distanceFromMainPosition < (maximumScalingArea + scalingArea) {
            // cell in scaling area
            let multiplier = abs((distanceFromMainPosition - maximumScalingArea) / scalingArea)
            preferredScale = maxScale - multiplier * (maxScale - minScale)
            preferredAlpha = maxAlpha - multiplier * (maxAlpha - minAlpha)
            
        } else {
            // cell in minimum-scaling area
            preferredScale = minScale
            preferredAlpha = minAlpha
        }
        return [ preferredScale, preferredAlpha ]
    }
}


public class ScaledVisibleCellsCollectionView {
    static let sharedInstance = ScaledVisibleCellsCollectionView()
    
    var maxScale: CGFloat = 1.0
    var minScale: CGFloat = 0.5
    
    var maxAlpha: CGFloat = 1.0
    var minAlpha: CGFloat = 0.5
    
    
}
