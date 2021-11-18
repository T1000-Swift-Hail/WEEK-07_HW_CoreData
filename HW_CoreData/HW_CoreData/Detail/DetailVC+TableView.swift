//
//  DetailVC+TableView.swift
//  HW_CoreData
//
//  Created by Mac on 18/11/2021.
//

import Foundation
import UIKit

extension DetailVC: UITableViewDelegate , UITableViewDataSource {
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = persons?[indexPath.row].name
        cell?.detailTextLabel?.text = "\(persons?[indexPath.row].phoneNumber ?? 0)"
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let person = persons?[indexPath.row]
            guard let person = person else { return }
            persons?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Delete From Core Data Object
            context.delete(person)
            PersistentStorage.shared.saveContext()
            
        }
    }
}
