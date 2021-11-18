//
//  TableViewVC.swift
//  PhoneBook
//
//  Created by Majed Alshammari on 12/04/1443 AH.
//

import UIKit
import CoreData
class TableViewVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let context = PersistentStorage.shared.context
    var phoneBook : [CDPhoneBook]? = []
    let cdPhoneBook = CDPhoneBook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        phoneBook = PersistentStorage.shared.fetchManagedObject(managedObject: CDPhoneBook.self)
        
    }
    @IBAction func add(_ sender: UIBarButtonItem) {
        alert()
    }
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
    
    
    
    func saveCoreData(name:String,phone:Int64) {
        
        let phoneBookModel = PhoneBooks(name: name, phone: phone)
        // Create Database
        cdPhoneBook.create(phoneBook: phoneBookModel)
        DispatchQueue.main.async {
            self.phoneBook = PersistentStorage.shared.fetchManagedObject(managedObject: CDPhoneBook.self)
            self.tableView.reloadData()
        }
        
        
    }
    
    
    func alert() {
        
        let alert = UIAlertController(title: "Add Friend", message: "", preferredStyle: .alert)
        
        alert.addTextField { fieldName  in
            fieldName.placeholder = "Friend Name"
            fieldName.returnKeyType = .next
            
        }
        
        alert.addTextField { fieldPhone  in
            
            fieldPhone.placeholder = "Friend Phone Number"
            fieldPhone.keyboardType = .numberPad
            fieldPhone.returnKeyType = .continue
        }
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            guard let fields = alert.textFields, fields.count == 2 else { return }
            let nameField = fields[0]
            let phoneNumber = fields[1]
            guard let name = nameField.text, !name.isEmpty,
                  let phone = phoneNumber.text, !phone.isEmpty else { return }
            guard let phone: Int64 = Int64(phone) else {return}
            self.saveCoreData(name: name, phone: phone)
            
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    
}
