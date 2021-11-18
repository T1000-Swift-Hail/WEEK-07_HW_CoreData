//
//  ContactVC.swift
//  AppContact
//
//  Created by Anas Hamad on 13/04/1443 AH.
//

import UIKit
import Foundation

extension TableViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = contacts?[indexPath.row].name
        cell?.detailTextLabel?.text = "\(contacts?[indexPath.row].number ?? 0)"
        
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts?.count ?? 0
    
    }
 
    func setDelegate(){
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let contact = contacts?[indexPath.row]
            guard let contact = contact else { return }
            contacts?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Delete From Core Data Object
            
            context.delete(contact)
            PersistentStorage.shared.saveContext()
    }
        
          }
    
    

     
        // Do any additional setup after loading the view.
    }
    

   


