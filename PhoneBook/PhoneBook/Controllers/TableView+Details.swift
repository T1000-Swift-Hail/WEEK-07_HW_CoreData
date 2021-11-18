//
//  TableView+Details.swift
//  PhoneBook
//
//  Created by Majed Alshammari on 12/04/1443 AH.
//

import Foundation
import UIKit


extension TableViewVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBook?.count ?? 0

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = phoneBook?[indexPath.row].name
        cell?.detailTextLabel?.text = "\(phoneBook?[indexPath.row].phone ?? 0 )"
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
        let phoneTable = phoneBook?[indexPath.row]
        guard let phoneTable = phoneTable else { return }
        phoneBook?.remove (at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
            context.delete(phoneTable)
            PersistentStorage.shared.saveContext()
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
