//
//  ViewController.swift
//  WEEK-07_HW_CoreData  WEEK-07_HW_CoreData  WEEK-07_HW_CoreData
//
//  Created by mona aleid on 13/04/1443 AH.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    
    let persistentContainer :NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { desc, error in
            if let error = error {
                print(error)
            }
        })
        
        return container
    }()
    
    var detaiedInfos : [InfoPhones] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchMyContacts()
    }
    
        func fetchMyContacts() {
            
            let context = persistentContainer.viewContext
            
            do {
                detaiedInfos =  try context.fetch(InfoPhones.fetchRequest())
            } catch {
                print(error)
            }
            
        }
        
    
 
    
    func addContact(name : String, phoneNumber : String) {
        
        let context = persistentContainer.viewContext
        
        context.performAndWait {
            let newContact = InfoPhones(context: context)
            newContact.name = name
            newContact.phoneNumber = phoneNumber
        }
    

    
        do {
         try context.save()
        } catch {
            print(error)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return detaiedInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        
        cell.textLabel?.text = detaiedInfos[indexPath.row].name
        cell.detailTextLabel?.text = detaiedInfos[indexPath.row].phoneNumber
        return cell
    }

    
    
    @IBAction func btnAddNewInfo(_ sender: Any) {
        let alert = UIAlertController(title: "Add Contact", message: nil, preferredStyle: .alert)

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "name .."
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Phone Number .."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let name = alert.textFields?.first?.text, let phone = alert.textFields?[1].text {

                self.addContact(name: name, phoneNumber: phone)
                self.fetchMyContacts()
                self.tableView.reloadData()
                
            }
        }))

        self.present(alert, animated: true)
    }
    
}
