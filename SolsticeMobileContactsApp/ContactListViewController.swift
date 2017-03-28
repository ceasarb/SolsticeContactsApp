//
//  ContactListViewController.swift
//  SolsticeMobileContactsApp
//
//  Created by Ceaz on 3/25/17.
//  Copyright © 2017 Seize Software. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var contacts: [Contact] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let client = SolsticeAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "Contacts"
        tableView.dataSource = self
        
        client.getContacts { (contacts, error) in
            if let contacts = contacts {
                self.contacts = contacts
            } else {
                
            }
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowContactDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let contactDetailVC = segue.destination as? ContactDetailTableViewController {
                    let contact = contacts[indexPath.row]
                    contactDetailVC.contact = contact
                }

            }
        }
    }

}

// MARK: - UITableViewDataSource 
extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell {
            
            let contact = contacts[indexPath.row]
            cell.displayInformation(for: contact)
            
            return cell
            
        } else {
            return UITableViewCell()
        }
        
    }
    
}
