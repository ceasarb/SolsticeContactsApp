//
//  ContactDetailTableViewController.swift
//  SolsticeMobileContactsApp
//
//  Created by Ceaz on 3/26/17.
//  Copyright © 2017 Seize Software. All rights reserved.
//

import UIKit

class ContactDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var workNumberLabel: UILabel!
    @IBOutlet weak var homeNumberLabel: UILabel!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var cityStateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    var contact: Contact?
    let client = SolsticeAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDisplay()
        
    }
    
    func updateDisplay() {
        guard let contact = self.contact else {
            return
        }
        
        guard let street = self.contact?.address?.street,
            let city = self.contact?.address?.city,
            let state = self.contact?.address?.state,
            let zip = self.contact?.address?.zipCode,
            let country = self.contact?.address?.country,
            let mobileNumber = self.contact?.phoneNumber?.mobile,
            let workNumber = self.contact?.phoneNumber?.work,
            let homeNumber = self.contact?.phoneNumber?.home else { return }
        
        contactNameLabel.text = contact.name
        companyNameLabel.text = contact.company
        emailLabel.text = contact.email
        websiteLabel.text = contact.website
        birthdayLabel.text = contact.birthdate
        mobileNumberLabel.text = mobileNumber
        workNumberLabel.text = workNumber
        homeNumberLabel.text = homeNumber
        streetAddressLabel.text = street
        cityStateLabel.text = "\(city), \(state)"
        zipCodeLabel.text = zip
        countryLabel.text = country
 
        
        if let largeImageURL = contact.largeImageURL {
            client.getDataForImage(url: largeImageURL, completion: { (data, error) in
                if let data = data {
                    self.contactImageView.image = UIImage(data: data)
                    self.contactImageView.layer.cornerRadius = self.contactImageView.frame.width / 2
                    self.contactImageView.layer.masksToBounds = true
                }
            })
        }
    }

    
    
}
