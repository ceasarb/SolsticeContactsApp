//
//  PhoneNumber.swift
//  SolsticeMobileContactsApp
//
//  Created by Ceaz on 3/27/17.
//  Copyright © 2017 Seize Software. All rights reserved.
//

import Foundation

struct PhoneNumber {
    let work: String?
    let home: String?
    let mobile: String?
}

extension PhoneNumber {
    struct Key {
        static let work = "work"
        static let home = "home"
        static let mobile = "mobile"
    }
    
    init?(phoneDict: [String: AnyObject]) {
        guard let workString = phoneDict[Key.work] as? String,
            let homeString = phoneDict[Key.home] as? String,
            let mobileString = phoneDict[Key.mobile] as? String else { return nil }
        
        self.work = workString
        self.home = homeString
        self.mobile = mobileString
    }
}
