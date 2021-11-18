//
//  DetalsVC.swift
//  CoreData
//
//  Created by iAbdullah17 on 13/04/1443 AH.
//

import UIKit
import CoreData

class DetalsVC: UIViewController {
    

    @IBOutlet weak var tableViewContacts: UITableView!
    
    
    
    var contacts : [Contact] = []
    
    let persistentContainer : NSPersistentContainer = {
       let container = NSPersistentContainer(name: "PhoneStore")
        container.loadPersistentStores(completionHandler: { desc, error in
            if let error = error {
                print(error)
            }
        })
        
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        fetchMyContacts()
        tableViewContacts.reloadData()
    }
    
    
    
    func fetchMyContacts() {
        let context = persistentContainer.viewContext
        
        do {
            contacts = try context.fetch(Contact.fetchRequest())
        }catch {
            print(error)
        }
    }
    
    
    func createNewContact(name: String, phoneNumber : String){
        let context = persistentContainer.viewContext
        
        context.performAndWait {
            let newContact = Contact(context: context)
            newContact.name = name
            newContact.phoneNumber  = phoneNumber
        }
        
        do {
            try context.save()
        }catch {
            print(error)
        }
        
    }

    @IBAction func addFriend(_ sender: Any) {
        alert()
    }
    
    func alert() {
        let alert = UIAlertController(title: "Add Friend", message: "", preferredStyle: .alert)
        alert.addTextField { textName in
            textName.placeholder = "Friend Name"
            
        }
        alert.addTextField { textNumber in
            textNumber.placeholder = "Friend Phone Number"
            
        }
    
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { ok in
            
            guard let fields = alert.textFields, fields.count == 2 else {return}
            let nameField = fields[0]
            let numberField = fields[1]
            
        
            guard let name = nameField.text , !name.isEmpty, let number = numberField.text, !number.isEmpty else {return}
            
            self.createNewContact(name: name, phoneNumber: number)
            self.fetchMyContacts()
            self.tableViewContacts.reloadData()
            
            
        }))
        
        present(alert, animated: true, completion: nil)
                        }
            
            
        
            
                        }
        
    
      

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

    

