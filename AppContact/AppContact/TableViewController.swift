//
//  TableViewController.swift
//  AppContact
//
//  Created by Anas Hamad on 13/04/1443 AH.
//

import UIKit
import CoreData

class TableViewController: UIViewController {
    
    @IBOutlet var numberLable: UILabel!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var addItem: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    
    let context = PersistentStorage.shared.context
    var contacts : [CDNote]? = []
    let cdContact = CDNote()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        contacts = PersistentStorage.shared.fetchManagedObject(managedObject: CDNote.self)
    }
    
    @IBAction func itemAdd(_ sender: Any) {
        
       
        displayalert()
        
     
        
        
    }
    func saveCoreData(name:String,number:String) -> Bool {
        
        if name == "" || number  == "" { return false }
        guard let number : Int16 = Int16(number) else {return false}
        let contact = Note(name: name, number: number)
        self.cdContact.create(note: contact)

        return true
    }

    
    func displayalert(){
        
        var textFieldUser = UITextField()
        var textFieldNumber = UITextField()
        
        let alert = UIAlertController(title: "Add Contact", message: "Writ Name and Number", preferredStyle: .alert)
        
        alert.addTextField {text in
            text.placeholder = "name..."
            textFieldUser = text
        }
        alert.addTextField{ textsec in
            textsec.placeholder = "Number..."
            textFieldNumber = textsec
        }
        
        
     let ok = UIAlertAction(title: "Okay", style: .default) { action in
         guard let text = textFieldUser.text else{return}
         guard let textsec = textFieldNumber.text else {return}
         if self.saveCoreData(name: text, number: textsec) {
             self.contacts = PersistentStorage.shared.fetchManagedObject(managedObject: CDNote.self)
             self.tableView.reloadData()
         }
         

        }
        
   
        present(alert, animated: true, completion: nil)
        
        alert.addAction(ok)
        
    
        }
    }
    
    
