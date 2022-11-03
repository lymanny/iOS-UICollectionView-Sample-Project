//
//  CardListCollectionViewCell.swift
//  CollectionView-2022-08-31
//
//  Created by Ly Manny on 31/8/22.
//

import UIKit

class CardListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var imageCardType   : UIImageView!
    @IBOutlet weak var labelCVC        : UILabel!
    @IBOutlet weak var labelValidThru  : UILabel!
    @IBOutlet weak var labelCardNumber : UILabel!
    
    //MARK: - Function
    func configCell(cardListRec: CardListData.Card.object) {
        labelCardNumber.text = cardListRec.cardNumber
        labelValidThru.text  = cardListRec.validThru
        labelCVC.text        = cardListRec.cvc
        imageCardType.image  = UIImage(named: cardListRec.cardType ?? "")
        
    }
    
}
