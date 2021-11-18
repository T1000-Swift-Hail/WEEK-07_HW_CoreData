//
//  CDPhoneBook.swift
//  PhoneBook
//
//  Created by Monafh on 13/04/1443 AH.
//

import Foundation
import CoreData

@objc(CDPhoneBook)
public class CDPhoneBook: NSManagedObject {

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: Int32
    
    func create(phoneBook: PhoneBookModel) {

        let context = PersistentStorage.shared.context
        let cdManage = CDPhoneBook(context: context)
        cdManage.name = phoneBook.name
        cdManage.phoneNumber = phoneBook.phoneNumber ?? 0
        
        PersistentStorage.shared.saveContext()

    }
}
