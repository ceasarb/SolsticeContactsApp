//
//  NetworkProcessing.swift
//  SolsticeMobileContactsApp
//
//  Created by Ceaz on 3/27/17.
//  Copyright © 2017 Seize Software. All rights reserved.
//

import Foundation


class NetworkProcessing {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias JSON = [[String: AnyObject]]
    typealias jsonCompletionHandler = (JSON?, SolsticeAPIError?) -> Void
    typealias dataCompletionHandler = (Data?, SolsticeAPIError?) -> Void
    
    func donwloadJson(with request: URLRequest, completion: @escaping jsonCompletionHandler) {
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, error as? SolsticeAPIError)
                }
            } else {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]]
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                default:
                    print("Received HTTP response code: \(httpResponse.statusCode) - was not handled in NetworkProcessing.swift file")
                    completion(nil, .responseUnsuccessful)
                }
            }
        }
        dataTask.resume()
    }
    
    
    func downloadDataForImage(with request: URLRequest, completion: @escaping dataCompletionHandler) {
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, error as? SolsticeAPIError)
                }
            } else {
                switch httpResponse.statusCode {
                case 200:
                    completion(data, nil)
                default:
                    print("Received HTTP response code: \(httpResponse.statusCode) - was not handled in NetworkProcessing.swift file")
                    completion(nil, .responseUnsuccessful)
                }
            }
        }
        
        dataTask.resume()
    }
}



