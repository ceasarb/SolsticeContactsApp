//
//  Address.swift
//  SolsticeMobileContactsApp
//
//  Created by Ceaz on 3/27/17.
//  Copyright © 2017 Seize Software. All rights reserved.
//

import Foundation

struct Address {
    let street: String?
    let city: String?
    let state: String?
    let country: String?
    let zipCode: String?
    let latitude: Double?
    let longitude: Double?
}

extension Address {
    
    struct Key {
        static let street = "street"
        static let city = "city"
        static let state = "state"
        static let country = "country"
        static let zip = "zip"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    init?(addressDict: [String: AnyObject]) {
        guard let streetString = addressDict[Key.street] as? String,
            let cityString = addressDict[Key.city] as? String,
            let stateString = addressDict[Key.state] as? String,
            let countryString = addressDict[Key.city] as? String,
            let zipString = addressDict[Key.zip] as? String,
            let latitude = addressDict[Key.latitude] as? Double,
            let longitude = addressDict[Key.longitude] as? Double else { return nil }
        
        self.street = streetString
        self.city = cityString
        self.state = stateString
        self.country = countryString
        self.zipCode = zipString
        self.latitude = latitude
        self.longitude = longitude
        
    }
}
