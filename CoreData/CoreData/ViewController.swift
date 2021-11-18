//
//  ViewController.swift
//  CoreData
//
//  Created by noyer altamimi on 13/04/1443 AH.
//

import UIKit
import Foundation
import CoreData


class ViewController: UITableViewController {

    var items = ["Hanan","Amal","Basma","Salma"]
    
    var contacts : [Contact] = []

    let persistentContainer : NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "PhoneBook")
        container.loadPersistentStores(completionHandler: { desc, error in
            if let error = error {
                print(error)
            }
            
        })
        
        return container
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchMyContacts()
        tableView.reloadData()
        
        
}
    
    
    func fetchMyContacts() {
        
        let context = persistentContainer.viewContext
        
        do {
            contacts =  try context.fetch(Contact.fetchRequest())
        } catch {
            print(error)
        }
        
    }
    
    
    func createNewContact( name : String, phoneNumber : String) {
        let context = persistentContainer.viewContext
        
        context.performAndWait {
            let newContact = Contact(context: context)
            newContact.name = name
            newContact.phoneNumber = phoneNumber
        }
        
        do {
         try context.save()
        }
        catch {
            print(error)
        }
    }
    

    @IBAction func AddButton(_ sender: Any) {
    
        
            let alert = UIAlertController(title: "Add Friend", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add", style: .default) { action in
                
        
                if let nameFromTextField = alert.textFields?[0].text, let phoneFromTextField = alert.textFields?[1].text {
                    
                    self.createNewContact(name: nameFromTextField, phoneNumber: phoneFromTextField)
                    self.fetchMyContacts()
                }
                
                self.tableView.reloadData()
                
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addTextField { textFiledSet in
                textFiledSet.placeholder = "Friend Name.."
                
            }
        
        alert.addTextField { textFiledSet in
            textFiledSet.placeholder = "Friend Phone.."
           
        }
        
            alert.addAction(cancel)
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
        }
        

        override func numberOfSections(in tableView: UITableView) -> Int {
           
            return 1
            
        }
        
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
            return contacts.count
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellUsers", for: indexPath)
            cell.textLabel?.text = contacts[indexPath.row].name
            cell.detailTextLabel?.text = contacts[indexPath.row].phoneNumber

            return cell
        
        }
      
}
     
