//
//  CDPhoneBook.swift
//  PhoneBook
//
//  Created by Asma on 17/11/2021.
//

import Foundation
import CoreData

@objc(CDPhoneBook)
public class CDPhoneBook: NSManagedObject {
    
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: Int16
    
    func create(phoneBook: PhoneBook) {
        
        let context = PersistentStorage.shared.context
        let cdPhone = CDPhoneBook(context: context)
        cdPhone.name = phoneBook.name
        cdPhone.phoneNumber = phoneBook.phoneNumber ?? 0
        
        PersistentStorage.shared.saveContext()
        
        
    }
  
}
