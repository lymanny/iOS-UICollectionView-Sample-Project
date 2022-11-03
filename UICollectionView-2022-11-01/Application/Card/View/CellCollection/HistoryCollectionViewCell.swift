//
//  HistoryCollectionViewCell.swift
//  CollectionView-2022-08-31
//
//  Created by Ly Manny on 12/9/22.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties & Variable
    var owner      : UIViewController!
    var receiptRec : [Receipt.object] = []
    
    //MARK: - Life Cycle
    override func awakeFromNib() {

    }
    
    func configCell(receiptRec: [Receipt.object]) {
        self.receiptRec = receiptRec
        tableView.reloadData()
    }
    
}

extension HistoryCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptRec.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptTableViewCell") as! ReceiptTableViewCell
        cell.configCell(receipt: receiptRec[indexPath.item])
        return cell
    }
    
}
