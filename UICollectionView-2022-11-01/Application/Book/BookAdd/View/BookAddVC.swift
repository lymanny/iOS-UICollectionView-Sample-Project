//
//  BookAddVC.swift
//  UICollectionView-2022-11-01
//
//  Created by Ly Manny on 1/11/22.
//

import UIKit

enum BookAddRowType: Int, CaseIterable {
    case Header
    case Body
}

enum BookType: Int, CaseIterable {
    case AddBook
    case EditBook
    case DetailBook
}

class BookAddVC: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var constraintBtnAddHeight : NSLayoutConstraint!
    @IBOutlet weak var btnAdd                 : UIButton!
    @IBOutlet weak var tableView              : UITableView!
    
    //MARK: - Variable
    var bookData              = BookData()
    var bookType              : BookType?
    var completionBookData    : CompletionData = {_,_,_ in}
    var bookImage             : UIImage?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    //MARK: - @IBAction
    @IBAction func btnAddBookClick(_ sender: Any) {
        let bookAddBodyCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? BookAddBodyCell
        
        if (bookAddBodyCell?.imageBook.image != nil) && (bookAddBodyCell?.textFieldTitle.text != "") && (bookAddBodyCell?.textViewDesc.text != "Give a description of your story" && bookAddBodyCell?.textViewDesc.text != "") {
            
            self.dismiss(animated: true) {
                self.completionBookData(self.bookImage!, bookAddBodyCell?.textFieldTitle.text ?? "", bookAddBodyCell?.textViewDesc.text ?? "")
            }
            
        } else {
            showAlert()
        }
        
    }
    
    //MARK: - Function
    func setUpView() {
        checkBookType()
    }
    
    func checkBookType() {
        if bookType == BookType.DetailBook {
            btnAdd.isHidden                 = true
            constraintBtnAddHeight.constant = 0
        } else {
            btnAdd.isHidden                 = false
            constraintBtnAddHeight.constant = 48
            btnAdd.setTitle(bookType == BookType.AddBook ? "Add Book" : "Update Book", for: .normal)
        }
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Please fill all content", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            print("===> Ok")
        }))
        
        self.present(alert, animated: true)
        
    }
    
    func openGallery (){
        self.openAlbum {
            let imagePickerController                       = QBImagePickerController()
            imagePickerController.modalPresentationStyle    = .fullScreen
            imagePickerController.delegate                  = self
            imagePickerController.allowsMultipleSelection   = true
            imagePickerController.mediaType                 = .image
            imagePickerController.maximumNumberOfSelection  = 1
            imagePickerController.numberOfColumnsInPortrait = 3
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
    }
    
    //MARK: - OBJC
    @objc func dismissVC() {
        self.dismiss(animated: true)
    }
    
    @objc func goToOpenGallery() {
        openGallery()
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension BookAddVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookAddRowType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowType = BookAddRowType(rawValue: indexPath.row)
        
        switch rowType {
            
        case .Header:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BookAddHeaderCell.IDENTIFIER) as! BookAddHeaderCell
            
            cell.btnClose.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
            cell.configCell(bookType: bookType ?? BookType.AddBook)
            
            return cell
            
        case .Body:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BookAddBodyCell.IDENTIFIER) as! BookAddBodyCell
            
            cell.textViewDesc.delegate = self
            cell.btnAddImageBook.addTarget(self, action: #selector(goToOpenGallery), for: .touchUpInside)
            cell.configCell(bookData: bookData, bookType: bookType ?? BookType.AddBook)
            
            return cell
            
        default: break
            
        }
        
        return UITableViewCell()
        
    }
    
}

//MARK: - UITextViewDelegate
extension BookAddVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let bookAddBodyCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? BookAddBodyCell {
            bookAddBodyCell.checkWhileInputText()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        tableView.performBatchUpdates(nil)
    }
    
}

// MARK: - QBImagePickerControllerDelegate
extension BookAddVC: QBImagePickerControllerDelegate {
    
    func qb_imagePickerControllerDidCancel(_ imagePickerController: QBImagePickerController!) {
        dismiss(animated: true, completion: nil)
    }
    
    func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [Any]!) {
        
        if let phAsset = assets.first as? PHAsset {
            
            let manager                           = PHImageManager.default()
            let requestOptions                    = PHImageRequestOptions()
            requestOptions.isSynchronous          = true
            requestOptions.deliveryMode           = .highQualityFormat
            requestOptions.resizeMode             = .exact
            requestOptions.isNetworkAccessAllowed = true
            
            self.dismiss(animated: true, completion: {
                manager.requestImageData(for: phAsset, options: requestOptions) { (assetData, assetString, orientation, infoDic) in
                    // Completed Image
                    guard let data = assetData else { return }
                    
                    // Completed Image
                    let img = UIImage(data: data)
                    print("===>img", img)
                    self.bookImage = img
                    
                    let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! BookAddBodyCell
                    cell.changeImageProfile(image: img!)
                }
            })
        }
    }
    
}



