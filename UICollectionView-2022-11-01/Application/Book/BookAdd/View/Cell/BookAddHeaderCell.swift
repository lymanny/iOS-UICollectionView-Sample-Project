//
//  BookAddHeaderCell.swift
//  UICollectionView-2022-11-01
//
//  Created by Ly Manny on 1/11/22.
//

import UIKit

class BookAddHeaderCell: UITableViewCell {

    @IBOutlet weak var btnClose   : UIButton!
    @IBOutlet weak var labelTitle : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(bookType: BookType) {
        
        switch bookType {
            
        case .AddBook:
            labelTitle.text = "AddBook"
            
        case .EditBook:
            labelTitle.text = "EditBook"
            
        case .DetailBook:
            labelTitle.text = "DetailBook"
        }
        
    }

}
