//
//  BookAddBodyCell.swift
//  UICollectionView-2022-11-01
//
//  Created by Ly Manny on 1/11/22.
//

import UIKit

class BookAddBodyCell: UITableViewCell {

    @IBOutlet weak var textViewDesc     : UITextView!
    @IBOutlet weak var textFieldTitle   : UITextField!
    @IBOutlet weak var btnAddImageBook  : UIButton!
    @IBOutlet weak var imageBook        : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textViewDesc.textContainerInset                = .zero
        textViewDesc.textContainer.lineFragmentPadding = 0
        textViewDesc.sizeToFit()
        textViewDesc.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(bookData: BookData, bookType: BookType) {
        
        switch bookType {
            
        case .AddBook:
            btnAddImageBook.isHidden = false
            btnAddImageBook.setImage(UIImage(named: "add"), for: .normal)
            
            imageBook.image          = UIImage(named: "")
            
            textFieldTitle.isUserInteractionEnabled   = true
            textFieldTitle.text                       = ""
            textFieldTitle.placeholder                = "Title"
            
            textViewDesc.isEditable = true
            textViewDesc.text = "Give a description of your story"
           
            
        case .EditBook:
            btnAddImageBook.isHidden = false
            btnAddImageBook.setImage(UIImage(named: ""), for: .normal)
            
            imageBook.image          = bookData.image
            
            textFieldTitle.isUserInteractionEnabled   = true
            textFieldTitle.text                       = bookData.title
            textFieldTitle.placeholder                = ""
            
            textViewDesc.isEditable = true
            textViewDesc.text = bookData.desc
            
            
        case .DetailBook:
            btnAddImageBook.isHidden = true
            
            imageBook.image          = bookData.image
            
            textFieldTitle.isUserInteractionEnabled   = false
            textFieldTitle.text                       = bookData.title
            textFieldTitle.placeholder                = ""
            
            textViewDesc.isEditable = false
            textViewDesc.text = bookData.desc
            
        }
      
    }
    
    func checkWhileInputText () {
        if textViewDesc.text == "Give a description of your story" {
            textViewDesc.text      = ""
        }
    }
    
    func changeImageProfile(image: UIImage) {
        imageBook.image          = image
        btnAddImageBook.setImage(UIImage(named: ""), for: .normal)
    
    }

}
