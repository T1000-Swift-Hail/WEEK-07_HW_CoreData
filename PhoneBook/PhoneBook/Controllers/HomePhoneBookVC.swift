//
//  HomePhoneBookVC.swift
//  PhoneBook
//
//  Created by Asma on 17/11/2021.
//

import UIKit
import CoreData

class HomePhoneBookVC: UIViewController {
    
    let context = PersistentStorage.shared.context
    let cdPhone = CDPhoneBook()
    var phone: [CDPhoneBook]? = []
    
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        phone = PersistentStorage.shared.fetchManagedObject(managedObject: CDPhoneBook.self)
    }
    
    
    @IBAction func addNumber(_ sender: UIBarButtonItem) {
        
        
        var name = UITextField()
        var number = UITextField()
        
        
        let alert = UIAlertController(title: "Add Friend", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            guard let name = name.text else { return }
            guard let number = number.text else { return }
            self.saveCoreData(name: name, phoneNumber: number)
        }

        alert.addTextField { filed in
            filed.placeholder = "Friend Name..."
            filed.returnKeyType = .next
            filed.keyboardType = .default
             name = filed
        }
        
        alert.addTextField { filed in
            filed.placeholder = "Friend Phone Number..."
            filed.returnKeyType = .continue
            filed.keyboardType = .numberPad
             number = filed
//          filed.isSecureTextEntry = true   
        }
          
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

        }
        
    func saveCoreData(name:String,phoneNumber:String) -> Bool {
        
        if name == "" || phoneNumber == "" { return false }
        guard let phoneNumber: Int16 = Int16(phoneNumber) else { return false }
        
        let phoneBook = PhoneBook(name: name, phoneNumber: phoneNumber)
        cdPhone.create(phoneBook: phoneBook)
        phone = PersistentStorage.shared.fetchManagedObject(managedObject: CDPhoneBook.self)
        tableView.reloadData()
        
        return true
    }

    }
    
    
    
    
    
    
