//
//  BookCell.swift
//  UICollectionView-2022-11-01
//
//  Created by Ly Manny on 1/11/22.
//

import UIKit

class BookCell: UICollectionViewCell {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var labelDesc   : UILabel!
    @IBOutlet weak var labelTitle  : UILabel!
    @IBOutlet weak var imageBook   : UIImageView!
    
    func configCell(bookData: BookData) {
        
        imageBook.image = bookData.image
        labelTitle.text = bookData.title
        labelDesc.text  = bookData.desc
        
    }
    
}
