//
//  UIViewController.swift
//  UICollectionView-2022-11-01
//
//  Created by Ly Manny on 1/11/22.
//

import UIKit

extension UIViewController {
    
    typealias Completion        = ()     -> Void
    typealias Completion_Bool   = (Bool) -> Void
    typealias CompletionData    = (UIImage, String, String)  -> Void
    
    func VC(sbName: String, identifier: String) -> UIViewController {
        return UIStoryboard(name: sbName, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func openAlbum(albumBlock:(()->Void)?) {
        
        let MESSAGE_PHOTO_ALBUM = "unable to  attach an image"
        
        self.checkAllowPhotoPermission { (status) in
            if status {
                albumBlock?()
            }
            else {
//                self.alertYesNo(title: "", message: MESSAGE_PHOTO_ALBUM, nobtn: "close".localized, yesbtn: "confirm".localized) { (yes) in
//                    if yes {
//                        self.gotoAppSettings()
//                    }
//                }
                
                let alert = UIAlertController(title: MESSAGE_PHOTO_ALBUM, message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { action in
                    print("No!")
                }))
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    print("Yes!")
                    self.gotoAppSettings()
                }))
                
                self.present(alert, animated: true)
            }
        }
    }
    
    func checkAllowPhotoPermission(completion: @escaping Completion_Bool) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            DispatchQueue.main.async {
                completion(true)
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                switch newStatus {
                case .authorized:
                    DispatchQueue.main.async {
                        completion(true)
                    }
                default:
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            })
        default:
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    func gotoAppSettings() {
        DispatchQueue.main.async {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
    }
    
    public static var IDENTIFIER: String {
        return String(describing: self)
    }
    
}
