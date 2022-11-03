//
//  HistoryCell.swift
//  CollectionView-2022-08-31
//
//  Created by Ly Manny on 12/9/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    //MARK: -   @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties & Variable
    var owner                   : UIViewController?
    var swipeCompletion         : (Int) -> Void = { _ in}
    
    let inset                   = CGFloat(20)
    var currentItem             = 0
    
    var dataReceipt             : [Any] = []

    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Function
    func setUpView() {
        self.collectionView.decelerationRate = .fast
        self.collectionView.delegate         = self
        self.collectionView.dataSource       = self
    }
    
    func configCell(dataReceipt: [Any]) {
        self.dataReceipt = dataReceipt
        collectionView.reloadData()
        
    }

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HistoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: inset, bottom: 0, right: inset) // +20 min spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - (inset * 2), height: collectionView.bounds.height) // - 40 cuz inset left 20 right 20
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataReceipt.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCollectionViewCell", for: indexPath) as! HistoryCollectionViewCell
        
        let receiptRec = dataReceipt[indexPath.item] as! [Receipt.object]
        cell.configCell(receiptRec: receiptRec)
        cell.owner = owner
        return cell
    }
    
}


//MARK: - UIScrollViewDelegate
extension HistoryTableViewCell: UIScrollViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let pageWidth = Float(collectionView.bounds.width - (inset * 2) + 20) // +20 min spacing
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width)
        var newPage = Float(currentItem)

        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? currentItem + 1 : currentItem - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }

        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = collectionView.indexPathForItem(at: center) {
            self.currentItem = ip.row
            self.swipeCompletion(ip.row)
        }
        
        DispatchQueue.main.async {
            self.owner?.view.layoutIfNeeded()
            self.collectionView.layoutIfNeeded()
        }
    }
    
}


