//
//  BookVC.swift
//  UICollectionView-2022-11-01
//
//  Created by Ly Manny on 1/11/22.
//

import UIKit

class BookVC: UIViewController {

    //MARK: - @IBOutlet
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var btnMoveCell    : UIButton!
    
    //MARK: - Variable
    var bookVM               = BookVM()
    var margin               : CGFloat = 10
    var isCanMoveCell        = false
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpNavAndStatusBarColor() // status bar has color the same as navigation
        setUpView()
        setUpGesture()
    }
    
    //MARK: - @IBAction
    @IBAction func btnAddClick(_ sender: Any) {
        // AddBook
        let vc = VC(sbName: "BookAddSB", identifier: BookAddVC.IDENTIFIER) as! BookAddVC
        
        vc.modalPresentationStyle = .automatic
        vc.bookType               = BookType.AddBook
        
        vc.completionBookData     = { img, title, desc in
            // append data
            self.bookVM.addBook(image: img, title: title, desc: desc)
            
            // insert insertItems
            self.collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
        }
        
        self.present(vc, animated: true)
    }
    
    @IBAction func moveCellClick(_ sender: Any) {
        isCanMoveCell = !isCanMoveCell
        
        if isCanMoveCell {
            btnMoveCell.setTitle("Can Move", for: .normal)
        } else {
            btnMoveCell.setTitle("Click Here To Move Cell", for: .normal)
        }
    }
    
    //MARK: - Function
    func setUpNavAndStatusBarColor() {
 
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor     = UIColor.black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance      = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance    = navigationController?.navigationBar.standardAppearance
        
        self.navigationItem.title      = "BookVC"
        
    }
    
    func setUpView() {
        
        bookVM.getBookData()
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.itemSize     = CGSize(width: (UIScreen.main.bounds.size.width/2) - (margin * 2), height: (collectionView.frame.height/2) - (margin * 2))
        layout.minimumInteritemSpacing         = 0
        layout.minimumLineSpacing              = margin
        collectionView!.collectionViewLayout   = layout
        
    }
    
    func setUpGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        collectionView.addGestureRecognizer(gesture)
    }
    
    func configureContextMenu(index: Int) -> UIContextMenuConfiguration {
        
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            // EditBook
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                print("===> edit button clicked")
                
                let vc = self.VC(sbName: "BookAddSB", identifier: BookAddVC.IDENTIFIER) as! BookAddVC
                
                vc.modalPresentationStyle = .automatic
                vc.bookType               = BookType.EditBook
                vc.bookData               = self.bookVM.bookData[index]
                vc.bookImage              = self.bookVM.bookData[index].image
                vc.completionBookData     = { img, title, desc in
                    // update data
                    self.bookVM.editBook(image: img, title: title, desc: desc, index: index)
                    
                    // reloadItems
                    DispatchQueue.main.async {
                        self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                    }
                }
            
                self.present(vc, animated: true)
                
            }
            
            // DeleteBook
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { (_) in
                print("===> delete button clicked")
                self.showAlert(index: index)
            }
            
            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [edit,delete])
            
        }
        return context
        
    }
    
    func showAlert(index: Int) {
        let alert = UIAlertController(title: "Do you want to delete this book?", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { action in
            print("===> No")
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("===> Yes")
            
            // delete data
            self.bookVM.bookData.remove(at: index)
            self.collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
            
        }))
        
        self.present(alert, animated: true)

    }
    
    //MARK: - OBJC
    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        guard let collectionView = collectionView else {
            return
        }
        
        switch gesture.state {
            
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
            
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
            
        case .ended:
            collectionView.endInteractiveMovement()
            
        default:
            collectionView.cancelInteractiveMovement()
        }
        
    }

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension BookVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Asks your data source object for the number of items in the specified section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookVM.bookData.count
    }

    // Asks your data source object for the cell that corresponds to the specified item in the collection view.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.IDENTIFIER, for: indexPath) as! BookCell
        
        cell.configCell(bookData: bookVM.bookData[indexPath.item])
        
        return cell
    }
    
    // Tells the delegate that the item at the specified index path was selected.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // DetailBook
        let vc = VC(sbName: "BookAddSB", identifier: BookAddVC.IDENTIFIER) as! BookAddVC
        
        vc.modalPresentationStyle = .automatic
        vc.bookType               = BookType.DetailBook
        vc.bookData               = bookVM.bookData[indexPath.item]
        
        self.present(vc, animated: true)
    }
    
    // Returns a context menu configuration for the item at a point.
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        if !isCanMoveCell {
            return configureContextMenu(index: indexPath.row)
        }
        return nil
      
    }
    
    // Tells the delegate that the specified cell is about to be displayed in the collection view.
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if  bookVM.bookData[indexPath.item].isAnimate {
            
            cell.alpha = 0
            cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                cell.alpha = 1
                cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
                
            })
            
        bookVM.bookData[indexPath.item].isAnimate = false
            
        }
    }
    
    // Re-order
    // Asks your data source object whether the specified item can move to another location in the collection view.
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Tells your data source object to move the specified item to its new location.
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if isCanMoveCell {
            let item = bookVM.bookData.remove(at: sourceIndexPath.item)
            bookVM.bookData.insert(item, at: destinationIndexPath.item)
        }
 
    }
 
}
