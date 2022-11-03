//
//  CardListTableViewCell.swift
//  CollectionView-2022-08-31
//
//  Created by Ly Manny on 31/8/22.
//

import UIKit

class CardListTableViewCell: UITableViewCell {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties & Variable
    var cardListRec          : [CardListData.Card.object] = [] // get cardListRec from CardListVC
    var viewController       : UIViewController? = nil // for present vc in CardListVC
    var currentSelectedIndex = 0
    
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - Function
    func setUpView() {
        collectionView.delegate             = self
        collectionView.dataSource           = self
        collectionView.collectionViewLayout = CardsCollectionFlowLayout()
    }
    
    func configCardCell(cardListRec: [CardListData.Card.object]){
        self.cardListRec = cardListRec
        self.collectionView.reloadData()
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CardListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardListRec.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardListCollectionViewCell", for: indexPath) as! CardListCollectionViewCell
        
        cell.configCell(cardListRec: cardListRec[indexPath.item])
        
        if currentSelectedIndex == indexPath.row {
            cell.transformToLarge()
        }
        
        return cell
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let currentCell = collectionView.cellForItem(at: IndexPath(row: Int(currentSelectedIndex), section: 0))
        currentCell?.transformToStandard()
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard scrollView == collectionView else {
            return
        }
        
        // Changing content offset to where the collection view stops scrolling
        targetContentOffset.pointee   = scrollView.contentOffset
        
        let flowLayout                = collectionView.collectionViewLayout as! CardsCollectionFlowLayout
        let cellWidthIncludingSpacing = flowLayout.itemSize.width + flowLayout.minimumLineSpacing
        let offset                    = targetContentOffset.pointee
        let horizontalVelocity        = velocity.x
        
        var selectedIndex             = currentSelectedIndex
        
        switch horizontalVelocity {
            // On user swiping
        case _ where horizontalVelocity > 0:
            selectedIndex = currentSelectedIndex + 1
            
        case _ where horizontalVelocity < 0:
            selectedIndex = currentSelectedIndex - 1
            
            // On user dragging
        case _ where horizontalVelocity == 0:
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            let roundedIndex = round(index)
            
            selectedIndex = Int(roundedIndex)
            
        default:
            print("Incorrect velocity for collection view")
        }
        
        let safeIndex         = max(0, min(selectedIndex, cardListRec.count - 1))
        let selectedIndexPath = IndexPath(row: safeIndex, section: 0)
        
        flowLayout.collectionView!.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
        
        let previousSelectedIndex = IndexPath(row: Int(currentSelectedIndex), section: 0)
        let previousSelectedCell  = collectionView.cellForItem(at: previousSelectedIndex)
        let nextSelectedCell      = collectionView.cellForItem(at: selectedIndexPath)
        
        currentSelectedIndex      = selectedIndexPath.row
        
        previousSelectedCell?.transformToStandard()
        nextSelectedCell?.transformToLarge()
        
        if let cardListVC = self.viewController as? CardListVC {
            cardListVC.reloadData(indexAmountOfEachCardRec: currentSelectedIndex)
        }
        
    }
    
}

