//
//  Contact.swift
//  SolsticeMobileContactsApp
//
//  Created by Ceaz on 3/26/17.
//  Copyright © 2017 Seize Software. All rights reserved.
//

import Foundation

struct Contact {
    let name: String
    let company: String?
    let phoneNumber: PhoneNumber?
    let address: Address?
    let smallImageURL: URL?
    let largeImageURL: URL?
    let email: String?
    let website: String?
    let birthdate: String?
}

extension Contact {
    struct Key {
        static let name = "name"
        static let company = "company"
        static let smallImageURL = "smallImageURL"
        static let largeImageURL = "largeImageURL"
        static let email = "email"
        static let website = "website"
        static let phone = "phone"
        static let address = "address"
        static let birthdate = "birthdate"
    }
    
    init?(contactDict: [String: AnyObject]) {
        guard let nameString = contactDict[Key.name] as? String,
            let companyString = contactDict[Key.company] as? String,
            let smallImageURLString = contactDict[Key.smallImageURL] as? String,
            let largeImageURLString = contactDict[Key.largeImageURL] as? String,
            let emailString = contactDict[Key.email] as? String,
            let websiteString = contactDict[Key.website] as? String else { return nil }
        
        if let addressDict = contactDict[Key.address] as? [String: AnyObject] {
            self.address = Address(addressDict: addressDict)
        } else {
            self.address = nil
        }
        
        if let phoneDict = contactDict[Key.phone] as? [String: AnyObject] {
            self.phoneNumber = PhoneNumber(phoneDict: phoneDict)
        } else {
            self.phoneNumber = nil
        }
        
        if let birthdayString = contactDict[Key.birthdate] as? String {
            let date = NSDate(timeIntervalSince1970: Double(birthdayString)!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let formattedDate = dateFormatter.string(from: date as Date)
            self.birthdate = formattedDate
        } else {
            self.birthdate = nil
        }

        
        self.name = nameString
        self.company = companyString
        self.email = emailString
        self.website = websiteString
        self.smallImageURL = URL(string: smallImageURLString)
        self.largeImageURL = URL(string: largeImageURLString)
        
    }
}



