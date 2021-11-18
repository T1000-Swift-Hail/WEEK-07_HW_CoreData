//
//  PhoneBookTableViewController.swift
//  week_7_coreData
//
//  Created by Ahmed Alenazi on 13/04/1443 AH.
//

import UIKit
import CoreData


class PhoneBookTableViewController: UITableViewController {
    
    
    let context = PersistentStorage.shared.context
    var phoneBook : [CDPhoneBook]? = []
    
    
    let contact = CDPhoneBook()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneBook = PersistentStorage.shared.fetchManagedObject(managedObject: CDPhoneBook.self)
        //         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return phoneBook?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = phoneBook?[indexPath.row].name
        cell?.detailTextLabel?.text = "\(phoneBook?[indexPath.row].number ?? 0)"
        return cell ?? UITableViewCell()
    }
    func saveCoreData(name:String,number:String) -> Bool {
        
        if name == "" || number  == "" { return false }
        guard let number: Int64 = Int64(number) else {return false}
        let phoneBook = PhoneBook(name: name, number: number)
        
        // Create Database
        contact.create(phoneBook: phoneBook)
        self.phoneBook = PersistentStorage.shared.fetchManagedObject(managedObject: CDPhoneBook.self)
        tableView.reloadData()
        return true
        
    }
    
    
    
    
    @IBAction func AddBotton(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Add Friend", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { [self] action in
            
            if let nameFromTextField = alert.textFields?[0].text , let phoneFromTextField =  alert.textFields?[1].text {
                
                if (self.saveCoreData(name: nameFromTextField, number: phoneFromTextField)){
                    
                    
                    
                    self.tableView.reloadData()
                }
                
            }
            
            
        }
        
        
        alert.addTextField { textFiledSet in
            textFiledSet.placeholder = "The Name..."
            
        }
        
        alert.addTextField(configurationHandler:{ textFiled in textFiled.placeholder = "Type The phone Number "})
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}


