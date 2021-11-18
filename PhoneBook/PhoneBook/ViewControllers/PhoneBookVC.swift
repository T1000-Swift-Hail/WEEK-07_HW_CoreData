//
//  ViewController.swift
//  PhoneBook
//
//  Created by Monafh on 13/04/1443 AH.
//

import UIKit

class PhoneBookVC: UIViewController {
    
    
    @IBOutlet weak var viewTable: UITableView!
    
    
    let context = PersistentStorage.shared.context
    var phonebook: [CDPhoneBook]? = []
    let phoneBooks = CDPhoneBook()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        phonebook = PersistentStorage.shared.fetchManagedObject(managedObject: CDPhoneBook.self)
    }
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        if viewTable.isEditing {
            viewTable.isEditing = false
        } else {
            viewTable.isEditing = true
        }
    }
    
    @IBAction func addNumber(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: .alert)
        
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name..."}
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Phone Number..." }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let nameTxF = alertController.textFields![0]
            let numberTxF = alertController.textFields![1]
            
            let nameTxf:String = nameTxF.text ?? ""
            let numberTxf:String = numberTxF.text ?? ""
            
            DispatchQueue.main.async {
                
                self.saveCoreData(name: nameTxf, phoneNumber: numberTxf)
                self.viewTable.reloadData()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        viewTable.reloadData()
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveCoreData(name:String,phoneNumber:String) {
        if name == "" || phoneNumber  == "" { return}
        guard let phoneNumber: Int32 = Int32(phoneNumber) else {return}
        let phoneA = PhoneBookModel(name: name, phoneNumber: phoneNumber)
        // Create Database
        phoneBooks.create(phoneBook:phoneA)
        phonebook = PersistentStorage.shared.fetchManagedObject(managedObject: CDPhoneBook.self)
    }
    
}

extension PhoneBookVC : UITableViewDelegate , UITableViewDataSource {
    
    func setDelegate() {
        viewTable.delegate = self
        viewTable.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        phonebook?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = phonebook?[indexPath.row].name
        cell?.detailTextLabel?.text = "\(phonebook?[indexPath.row].phoneNumber ?? 0)"
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let phonebooks = phonebook?[indexPath.row]
            guard let phonebooks = phonebooks else { return }
            phonebook?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            context.delete(phonebooks)
            PersistentStorage.shared.saveContext()
            
        }
    }
}
