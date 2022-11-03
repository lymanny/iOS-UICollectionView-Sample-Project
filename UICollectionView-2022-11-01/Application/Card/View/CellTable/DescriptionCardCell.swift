//
//  DescriptionCardCell.swift
//  CollectionView-2022-08-31
//
//  Created by Ly Manny on 31/8/22.
//

import UIKit

class DescriptionCardCell: UITableViewCell {

    //MARK: - @IBOutlet
    @IBOutlet weak var labelValue : UILabel!
    @IBOutlet weak var labelTitle : UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Function
    func configCell(amountOfEachCardRec: CardListData.AmountOfEachCard.object) {
        labelValue.text = amountOfEachCardRec.value
    }

}
