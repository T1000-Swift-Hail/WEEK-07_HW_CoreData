//
//  ViewController.swift
//  CoreData HW
//
//  Created by Seham الشطنان on 13/04/1443 AH.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contactsTableView: UITableView!
    
    let persitentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model" )
        container.loadPersistentStores(completionHandler: { desc, error in
            if let error = error {
                print(error)
            }
            
        })
        
        return container
        }()
    
    
    
    var contacts : [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        
        //createContact(name : "fds", phoneNumber: "84375983" )
        
        fetchContacts()
    }


    
    func fetchContacts() {
        
        let context = persitentContainer.viewContext
        
        do {
            contacts = try context.fetch(Person.fetchRequest())
         }
        catch {
            print(error)
         }
    }
    
    
    func createContact(name : String, phoneNumber: String ) {
        
        let context = persitentContainer.viewContext
        
        context.performAndWait {
            let person = Person(context: context)
            person.name = name
            person.phoneName = phoneNumber
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
        cell.detailTextLabel?.text = contacts[indexPath.row].phoneName
        
        return cell
    }
    
    @IBAction func addContact(_ sender: Any) {
        
        
        //getting an instance of UIAlertController
        let alert = UIAlertController(title: "Add new contact", message: nil, preferredStyle: .alert)
        
        //Adding Cancel Button
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //adding a text field
        alert.addTextField(configurationHandler: { textField in
         textField.placeholder = "contact name"
        })
        
        //adding a text field
        alert.addTextField(configurationHandler: { textField in
         textField.placeholder = "phone number"
        })
        
        //adding an action "O.K."
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

          if let nameFromTextField = alert.textFields?.first?.text, let numberFromTextField = alert.textFields?[1].text {
           
              self.createContact(name: nameFromTextField, phoneNumber: numberFromTextField)
              
              self.fetchContacts()
              self.contactsTableView.reloadData()
              
          }
                
       }))

      self.present(alert, animated: true)
    }

}




