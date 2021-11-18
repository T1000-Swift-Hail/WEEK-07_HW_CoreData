//
//  ViewController.swift
//  PhoneBook
//
//  Created by Hind Alharbi on 11/18/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableV: UITableView!
    
   
    let persistentContainer : NSPersistentContainer  = {
       
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { desc, error in
            if let error = error {
                print(error)
            }
        })
        
        return container
    }()
    
    
    var contacts : [ContactsFriends] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableV.delegate = self
       tableV.dataSource = self
        
        fetchMyContacts()
        
    }
    
    
    func fetchMyContacts() {
        
        let context = persistentContainer.viewContext
        
        do {
         contacts =  try context.fetch(ContactsFriends.fetchRequest())
        } catch {
            print(error)
        }
        
    }
    
    
    func createContact(name : String, phone : String) {
        
        let context = persistentContainer.viewContext
        
        context.performAndWait {
            let newContact = ContactsFriends(context: context)
            newContact.name = name
            newContact.phone = phone
        }
        
        do {
         try context.save()
        } catch {
            print(error)
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row].name
        cell.detailTextLabel?.text = contacts[indexPath.row].phone
        return cell
    }

    @IBAction func addNewContact(_ sender: Any) {
        let alert = UIAlertController(title: "Add Contact", message: nil, preferredStyle: .alert)

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "name .."
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Friend Number Phone .."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let name = alert.textFields?.first?.text, let phone = alert.textFields?[1].text {

                self.createContact(name: name, phone: phone)
                self.fetchMyContacts()
                self.tableV.reloadData()
                
            }
        }))

        self.present(alert, animated: true)
    }
    
}

