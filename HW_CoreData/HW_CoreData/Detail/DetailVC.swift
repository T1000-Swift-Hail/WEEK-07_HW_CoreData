//
//  DetailVC.swift
//  HW_CoreData
//
//  Created by Mac on 18/11/2021.
//

import UIKit
import CoreData

class DetailVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let context = PersistentStorage.shared.context
    var persons: [CDPerson]? = []
    
    let cdPerson = CDPerson()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        persons = PersistentStorage.shared.fetchManagedObject(managedObject: CDPerson.self)
        tableView.reloadData()
//        print(persons)
    }
    
    func saveCoreData(name:String,phoneNumber:String) -> Bool {
        
        if name == "" || phoneNumber  == "" { return false }
        guard let phoneNumber: Int32 = Int32(phoneNumber) else {return false}
        let person = Person(name: name, phoneNumber: phoneNumber)
        
        // Create Database
        cdPerson.create(person: person)
        
        return true
        
    }

        @IBAction func add(_ sender: Any) {
            
           
                  let alert = UIAlertController(title: "Add Friend", message: "", preferredStyle: .alert)
            
                  let action = UIAlertAction(title: "Add", style: .default) { [self] action in
                      
                      if let nameFromTextField = alert.textFields?[0].text , let phoneFromTextField =  alert.textFields?[1].text {
                          
                          if (self.saveCoreData(name: nameFromTextField, phoneNumber: phoneFromTextField)){
                              
                              self.persons = PersistentStorage.shared.fetchManagedObject(managedObject: CDPerson.self)
                              
                              self.tableView.reloadData()
                          }
                          
                      }

                      
                  }
            
                 
                  alert.addTextField { textFiledSet in
                      textFiledSet.placeholder = "Write Name..."

                  }
            
            alert.addTextField(configurationHandler:{ textFiled in textFiled.placeholder = "Type you phone Number "})
            
                  alert.addAction(action)
                  
                  present(alert, animated: true, completion: nil)
           
            }
        


    
}



