//
//  TableViewController.swift
//  HWCoreData
//
//  Created by موضي الحربي on 13/04/1443 AH.
//

import UIKit


struct Person {
    
    let name : String?
    let number : String?
    
}


class TableViewController: UITableViewController {

    let context = PersistentStorage.shared.context
    var persons : [CDPerson]? = []
    let cdPerson = CDPerson()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        persons = PersistentStorage.shared.fetchManagedObject(managedObject: CDPerson.self)
        
    }
        
        
    @IBAction func addPerson(_ sender: UIBarButtonItem) {
        
        
        
        var nameFiled = UITextField()
        
        var numberFiled = UITextField()
         
        let alert = UIAlertController(title: "Add New contact", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
            alert.addTextField { textfiled in textfiled.placeholder = "contact name"
         nameFiled = textfiled
        
        }
        
            alert.addTextField { textfiled in textfiled.placeholder = "phon number"
         numberFiled = textfiled
        
        }
          
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
                guard let name = nameFiled.text else
               
                       { return }
         
                guard let number = numberFiled.text
                else { return }
            
                self.saveTODataBase(name: name,phoneNumber: number )
            
            
            }))
            self.present(alert, animated: true)
        }
            
        
        
        func
        saveTODataBase
        (name:String,phoneNumber:String)  {
            
         let person = Person(name: name, number: phoneNumber)
            
            cdPerson.creat(person: person)
            
            DispatchQueue.main.async {
                
                self.persons =
                PersistentStorage.shared.fetchManagedObject(managedObject: CDPerson.self)
                self.tableView.reloadData()
            }
            
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return persons?.count ?? 0
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            
            
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text =
            persons?[indexPath.row].name
        cell.detailTextLabel?.text =
            persons?[indexPath.row].phoneNumber
            
            return cell
            
        }
          
    }

        
        
        
        

    
    
    
