//
//  ViewController.swift
//  WEEK-07_HW_CoreData
//
//  Created by mac on 12/04/1443 AH.

import UIKit
import CoreData

class RegistrationVC: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userNamber: UITextField!
    
    let context = PersistentStorage.shared.context
    let cdPerson = CDPerson()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func skip(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toDetals", sender: nil)
    }
    @IBAction func singUp(_ sender: UIButton) {
        
        if saveCoreData(name: userName.text ?? "", number: userNamber.text ?? "") {
            performSegue(withIdentifier: "toDetals", sender: nil)
        } else {
            print("please try Again!!")
        }
        userName.text = ""
        userNamber.text = ""
        
    }
    func saveCoreData(name:String,number:String) -> Bool {
        
        print("person:\(number)")
        if name == "" || number  == "" { return false }
        if !(Int64(number) != nil) {
            return false
        }
        let person = Person(name: name, number: number)
        // Create Database
        cdPerson.create(person: person)
        
        return true
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
