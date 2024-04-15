//
//  ContactsCell.swift
//  P2PCloudApp
//
//  Created by onur yılmaz on 12.05.2023.
//

import UIKit

class ContactsCell: UITableViewCell {
    @IBOutlet weak var contactsView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageProfileTapped))
        imageProfile.addGestureRecognizer(tapGesture)
        imageProfile.isUserInteractionEnabled = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    @objc private func imageProfileTapped() {
        guard let viewController = findViewController() else {
            return
        }
        
        let userDetailsVC = UserDetailsVC()
       
        
        viewController.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}
    private extension UIView {
           func findViewController() -> UIViewController? {
               var nextResponder: UIResponder? = self
               while let responder = nextResponder {
                   if let viewController = responder as? UIViewController {
                       return viewController
                   }
                   nextResponder = responder.next
               }
               return nil
           }
       }

