//
//  ViewController.swift
//  MyPhoneBook
//
//  Created by Huda N S on 13/04/1443 AH.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var contactsTableView: UITableView!
    let persistentContainer : NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "PhoneBook")
        container.loadPersistentStores(completionHandler: { desc, error in
            if let error = error {
                print(error)
            }
        })
        return container
    }()
    
    
    var contacts : [Contact] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        fetchMyContacts()
    }
    
    
    func fetchMyContacts() {
        let context = persistentContainer.viewContext
        do {
         contacts =  try context.fetch(Contact.fetchRequest())
        } catch {
            print(error)
        }
    }

    func createContact(name : String, phone : String) {
        let context = persistentContainer.viewContext
        context.performAndWait {
            let newContact = Contact(context: context)
            newContact.name = name
            newContact.phoneNumber = phone
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row].name
        cell.detailTextLabel?.text = contacts[indexPath.row].phoneNumber
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
                self.contactsTableView.reloadData()
            }
        }))

        self.present(alert, animated: true)
    }
}

