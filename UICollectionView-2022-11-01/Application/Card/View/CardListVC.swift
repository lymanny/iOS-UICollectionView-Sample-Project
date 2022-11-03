//
//  CardListVC.swift
//  CollectionView-2022-08-31
//
//  Created by Ly Manny on 31/8/22.
//

import UIKit

class CardListVC: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties & Variable
    var cardListDataVM            = CardListDataVM()
    var indexAmountOfEachCardRec  = 0
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //MARK: - Function
    func setUpView() {
        cardListDataVM.getCardListData()
    }
    
    func reloadData(indexAmountOfEachCardRec: Int) {
        self.indexAmountOfEachCardRec = indexAmountOfEachCardRec
        tableView.reloadData()
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CardListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardListDataVM.cardListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowType = cardListDataVM.cardListData[indexPath.row].rowType
        
        switch rowType {
            
        case .Banner:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell") as! BannerTableViewCell
            return cell
            
        case .Card:
            
            let cardListRec = cardListDataVM.cardListData[indexPath.row].value as! [CardListData.Card.object]
            
            if cardListRec.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CardListTableViewCell") as! CardListTableViewCell
                cell.viewController = self
                cell.configCardCell(cardListRec: cardListRec)
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NoneCardListTableViewCell") as! NoneCardListTableViewCell
                return cell
            }
            
        case .AmountOfEachCard:
            
            let amountOfEachCardRec = cardListDataVM.cardListData[indexPath.row].value as! [CardListData.AmountOfEachCard.object]
            
            if amountOfEachCardRec.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCardCell") as! DescriptionCardCell
                cell.configCell(amountOfEachCardRec: amountOfEachCardRec[indexAmountOfEachCardRec])
                return cell
                
            }else {
                return UITableViewCell()
            }
            
        case .Receipt:
            
            let cell   = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as! HistoryTableViewCell
            cell.configCell(dataReceipt: cardListDataVM.cardListData[indexPath.row].value as! [Any])
            cell.owner = self
            
            return cell
            
        default: return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowType = cardListDataVM.cardListData[indexPath.row].rowType
        
        switch rowType {
            
        case .Receipt:
            let receiptRec = cardListDataVM.cardListData[indexPath.row].value as! [Any]
            return CGFloat(((receiptRec[0] as AnyObject).count * 82))
            
        default: return UITableView.automaticDimension
        }
    }
    
}
