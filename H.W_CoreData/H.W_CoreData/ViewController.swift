//
//  ViewController.swift
//  H.W_CoreData
//
//  Created by Hesah Alqhtani on 18/11/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
                            
    let persistentContainer : NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { desc, error in
            if let error = error {
                print(error)
            }
        })
        
        return container
    }()
    
    
    var contacts : [ContanctNames] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchMyContacts()
        
    }
    
    
    func fetchMyContacts() {
        
        let context = persistentContainer.viewContext
        
        do {
         contacts =  try context.fetch(ContanctNames.fetchRequest())
        } catch {
            print(error)
        }
        
    }
    
    
    func createContact(name : String, phoneNamber : String) {
        
        let context = persistentContainer.viewContext
        
        context.performAndWait {
            let newContact = ContanctNames(context: context)
            newContact.name = name
            newContact.phoneNamber = phoneNamber
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
        cell.detailTextLabel?.text = contacts[indexPath.row].phoneNamber
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

                self.createContact(name: name, phoneNamber: phone)
                self.fetchMyContacts()
                self.tableView.reloadData()
                
            }
        }))

        self.present(alert, animated: true)
    }
    
}

