//
//  DetalsVC+TableView.swift
//  CoreData
//
//  Created by iAbdullah17 on 13/04/1443 AH.
//

import Foundation
import UIKit 


extension DetalsVC: UITableViewDelegate , UITableViewDataSource {
    
    
    func setDelegate() {
        tableViewContacts.delegate = self
        tableViewContacts.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row].name
        cell.detailTextLabel?.text = contacts[indexPath.row].phoneNumber
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let friend = people? [indexPath.row]
//            guard let person = friend else {return}
//            people?.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            contex.delete(person)
//            PersistentStorage.shared.saveContext()
//        }
//    }
}
