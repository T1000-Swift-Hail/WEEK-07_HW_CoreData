//
//  ViewController.swift
//  CoreData
//
//  Created by HIND12 on 13/04/1443 AH.
//

import UIKit
import CoreData

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var contactTableView: UITableView!
    
    
    let persitentContainner : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { desc,error in
            if let error = error {
                print (error)
            }
    })
    
        return container
    }()
    
    
    var contacts : [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactTableView.dataSource = self
        contactTableView.delegate = self
    
    }
    
    
    func fetchcontacts() {
        let context = persitentContainner.viewContext
        do {
            contacts = try context.fetch(Person.fetchRequest())
        }
        catch {
        print(error)
        }
    }
    
    
    func createContact(name :String , phoneNumber: String) {
        let context = persitentContainner.viewContext
        context.performAndWait {
            let person = Person(context: context)
            
            person.name = name
            person.phoneNamber = phoneNumber
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
        cell . textLabel?.text = contacts [indexPath.row].name

        
        cell.detailTextLabel?.text =  contacts[indexPath.row].phoneNamber
        return cell
    }





    
    
  }


