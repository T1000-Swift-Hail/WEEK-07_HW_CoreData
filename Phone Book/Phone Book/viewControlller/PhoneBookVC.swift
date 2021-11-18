//
//  PhoneBookVC.swift
//  BookPhoneP
//
//  Created by Dalal AlSaidi on 13/04/1443 AH.
//

import UIKit
import CoreData

class PhoneBookVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let context = PersistentStorage.shared.context
    var phonebooks: [CDManage]? = []
    let phonebook = CDManage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        phonebooks = PersistentStorage.shared.fetchManagedObject(managedObject: CDManage.self)
    }
    
    @IBAction func adding(_ sender: Any) {
        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name..."
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let nameTxtFiled = alertController.textFields![0]
            let numberTxtFiled = alertController.textFields![1]
            let nameTxtF:String = nameTxtFiled.text ?? ""
            let numberTxt:String = numberTxtFiled.text ?? ""
            
            DispatchQueue.main.async {
                self.saveCoreData(name: nameTxtF, phoneNumber: numberTxt)
                self.tableView.reloadData()
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Phone Number..."
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        tableView.reloadData()
        
        self.present(alertController, animated: true, completion: nil)
    }
    func saveCoreData(name:String,phoneNumber:String) {
        if name == "" || phoneNumber  == "" { return}
        guard let phoneNumber: Int32 = Int32(phoneNumber) else {return}
        let phoneB = PhoneBook(name: name, phoneNumber: phoneNumber)
        // Create Database
        phonebook.create(phone:phoneB)
        phonebooks = PersistentStorage.shared.fetchManagedObject(managedObject: CDManage.self)
    }
}

extension PhoneBookVC: UITableViewDelegate , UITableViewDataSource {
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        phonebooks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = phonebooks?[indexPath.row].name
        cell?.detailTextLabel?.text = "\(phonebooks?[indexPath.row].phoneNumber ?? 0)"
        
        return cell ?? UITableViewCell()
    }
    
}
