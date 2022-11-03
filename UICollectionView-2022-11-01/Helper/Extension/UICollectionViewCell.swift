//
//  UITableViewCell.swift
//  UICollectionView-2022-11-01
//
//  Created by Ly Manny on 1/11/22.
//

import UIKit

extension UICollectionViewCell {
    
    public static var IDENTIFIER: String {
        return String(describing: self)
    }
    
    func transformToLarge() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    func transformToStandard() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
//            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
    }
    
}
