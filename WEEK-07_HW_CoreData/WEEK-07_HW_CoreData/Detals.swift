//
//  Detals.swift
//  WEEK-07_HW_CoreData
//
//  Created by mac on 12/04/1443 AH.
//

import UIKit
import CoreData

class DetalsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = PersistentStorage.shared.context
    var persons: [CDPerson]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        persons = PersistentStorage.shared.fetchManagedObject(managedObject: CDPerson.self)
    }
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
    
}
