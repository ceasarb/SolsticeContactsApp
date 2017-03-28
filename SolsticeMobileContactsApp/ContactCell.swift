//
//  ContactCell.swift
//  SolsticeMobileContactsApp
//
//  Created by Ceaz on 3/26/17.
//  Copyright © 2017 Seize Software. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneNumberLabel: UILabel!
    
    let client = SolsticeAPIClient()
    
    func displayInformation(for contact: Contact) {
        contactNameLabel.text = contact.name
        
        if let phoneNumber = contact.phoneNumber {
            contactPhoneNumberLabel.text = phoneNumber.mobile
        }
        
        if let smallImageURL = contact.smallImageURL {
            client.getDataForImage(url: smallImageURL) { (data, error) in
                if let data = data {
                    self.contactImageView.image = UIImage(data: data)
                    self.contactImageView.layer.cornerRadius = self.contactImageView.frame.width / 2
                    self.contactImageView.layer.masksToBounds = true
                } else {
                    self.contactImageView.image = #imageLiteral(resourceName: "default")
                }
                
            }
        }
        
        
        
    }
}
