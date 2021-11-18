//
//  TableViewController.swift
//  CoreDataHW
//
//  Created by MACBOOK on 12/04/1443 AH.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    var names: [String:Int] = ["Mohammed":1234,"Salim":2234,"Ahmed":12332]
    
    
    let context = FriendStorage.shared.context
    var persons: [CDFriend]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        persons = FriendStorage.shared.fetchManagedObject(managedObject: CDFriend.self)
        tableView.reloadData()
    }
    
    
    
    ////    var names = ["Mohammed","Salim","Murad Ahmed","Karim"]
//    var numbers = [0,1]
    @IBOutlet var detaliVc: UITableView!
    
    @IBAction func addItem(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Add Friend", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { [self] action in
            
            if let nameFromTF = alert.textFields?[0].text , let phoneFromTF = alert.textFields?[1].text {
                
                let newFriend = Friend(nameFrind: nameFromTF, phonNumber: Int16(phoneFromTF))
                
                let cdFriend = CDFriend()
                cdFriend.create(friend: newFriend)
                self.persons = FriendStorage.shared.fetchManagedObject(managedObject: CDFriend.self)
                self.tableView.reloadData()
            }
            
            
            
        }
        let cancal = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        
        alert.addTextField { textFiledSet in
            textFiledSet.placeholder = "Write Names..."
        
        }
        
        alert.addTextField(configurationHandler:{ textFiled in
           
            textFiled.placeholder = "Friend Number "
            
        })
        
        
        alert.addAction(cancal)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    

    
//        override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = persons?[indexPath.row].nameFriend ?? ""
        cell.detailTextLabel?.text = "\(persons?[indexPath.row].phonNumber ?? Int16(0))"
      
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
