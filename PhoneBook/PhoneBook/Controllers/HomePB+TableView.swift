//
//  HomePB+TableView.swift
//  PhoneBook
//
//  Created by Asma on 17/11/2021.
//

import Foundation
import UIKit


extension HomePhoneBookVC: UITableViewDelegate, UITableViewDataSource {
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        phone?.count  ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = phone?[indexPath.row].name
        cell.detailTextLabel?.text = "\(phone?[indexPath.row].phoneNumber ?? 0)"

        return cell
    }
    
    
    
}
    
