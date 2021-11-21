//
//  TableViewController.swift
//  CordData
//
//  Created by طلال عبيدالله دعيع القلادي on 17/11/2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    let context = PersistentStorage.shared.context
    let cdPerson = CDPerson()
    var persons: [CDPerson]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        persons = PersistentStorage.shared.fetchManagedObject(managedObject: CDPerson.self)
        
        func saveCoreData(name:String,number:String) -> Bool {
            
            if name == "" || number  == "" { return false }
            guard let number: Int64 = Int64(number) else {return false}
            let person = Person(name: name, number: number )
            
            // Create Database
            cdPerson.create(person: person)
            
            return true
            
        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons?.count ?? 0
    }
    override func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = persons?[indexPath.row].name
        cell?.detailTextLabel?.text = "\(persons?[indexPath.row].number ?? 0)"
        
        return cell ?? UITableViewCell()
        
    }
    
    @IBAction func AddNew(_ sender: Any) {
//
//        var textFiled = UITextField()
//        let alert = UIAlertController(title: "Add New ", message: "", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Add", style: .default) { action in
//
//            guard let text = textFiled.text else {return}
        var firstTextFiled = UITextField()
        var secondTextFiled = UITextField()
        let alert = UIAlertController(title: "Add Friend", message: "", preferredStyle: .alert )
        alert.addTextField { textfiled in
            textfiled.placeholder = "First Name"
            
            
            
            firstTextFiled = textfiled
        }
        alert.addTextField { textfiled in
            textfiled.placeholder = "Phone Number"
            
            
            
            secondTextFiled = textfiled
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
            if firstTextFiled.text != "" || secondTextFiled.text != "" {
                guard let number:Int64 = Int64(secondTextFiled.text ?? "nil") else { return }
                
                let person = Person(name: firstTextFiled.text, number: number)
                self.cdPerson.create(person: person)
                DispatchQueue.main.async {
                    self.persons = PersistentStorage.shared.fetchManagedObject(managedObject: CDPerson.self)
                    self.tableView.reloadData()
                }
                
            }
            
            
            
        }))
            self.tableView.reloadData()
        self.present(alert, animated : true , completion: nil )
            
    }
   
}

