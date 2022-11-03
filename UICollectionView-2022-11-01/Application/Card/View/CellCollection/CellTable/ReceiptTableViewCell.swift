//
//  ReceiptTableViewCell.swift
//  CollectionView-2022-08-31
//
//  Created by Ly Manny on 12/9/22.
//

import UIKit

class ReceiptTableViewCell: UITableViewCell {

    @IBOutlet weak var labelPrice : UILabel!
    @IBOutlet weak var labelType  : UILabel!
    @IBOutlet weak var labelDate  : UILabel!
    @IBOutlet weak var labelName  : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(receipt: Receipt.object) {
        labelName.text  = receipt.name
        labelDate.text  = receipt.date
        labelType.text  = receipt.type
        labelPrice.text = receipt.price
        
    }

}
