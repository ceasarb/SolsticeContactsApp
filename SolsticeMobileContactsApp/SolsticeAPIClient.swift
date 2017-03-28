//
//  SolsticeAPIClient.swift
//  SolsticeMobileContactsApp
//
//  Created by Ceaz on 3/27/17.
//  Copyright © 2017 Seize Software. All rights reserved.
//

import Foundation

class SolsticeAPIClient {
    
    let baseURL = "https://s3.amazonaws.com/technical-challenge/Contacts_v2.json"
    
    let networkProcessing = NetworkProcessing()
    
    typealias contactCompletionHandler = ([Contact]?, SolsticeAPIError?) -> Void
    typealias dataCompletionHandler = (Data?, SolsticeAPIError?) -> Void
    
    func getContacts(completionHandler completion: @escaping contactCompletionHandler) {
        
        var contacts: [Contact] = []
        
        guard let url = URL(string: baseURL) else {
            completion(nil, .invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        networkProcessing.donwloadJson(with: request) { (json, error) in
            DispatchQueue.main.async {
                
                guard let contactDictionaries = json else {
                    print(error.debugDescription)
                    completion(nil, error)
                    return
                }
                
                
                for contactDict in contactDictionaries {
                    if let contact = Contact(contactDict: contactDict) {
                       contacts.append(contact)
                    } else {
                        completion(nil, .jsonParsingError)
                    }
                    
                }
                
                completion(contacts, nil)
                
            }
        }
    }
    
    
    func getDataForImage(url: URL, completion: @escaping dataCompletionHandler) {
        
        let request = URLRequest(url: url)
        networkProcessing.downloadDataForImage(with: request) { (data, error) in
            DispatchQueue.main.async {
                if let err = error {
                    completion(nil, err)
                } else if let data = data {
                    completion(data, nil)
                }
            }
        }
        
    }
    
    
    
    
}















