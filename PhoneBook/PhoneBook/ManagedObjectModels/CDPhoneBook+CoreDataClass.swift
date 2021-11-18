//
//  CDPhoneBook+CoreDataClass.swift
//  PhoneBook
//
//  Created by Majed Alshammari on 12/04/1443 AH.
//

import Foundation

import Foundation
import CoreData

@objc(CDPhoneBook)
public class CDPhoneBook: NSManagedObject {

    @NSManaged public var name: String?
    @NSManaged public var phone: Int64
    
    func create(phoneBook: PhoneBooks) {

        let context = PersistentStorage.shared.context
        let cdPhoneBook = CDPhoneBook(context: context)
        cdPhoneBook.name = phoneBook.name
        cdPhoneBook.phone  = phoneBook.phone ?? 0
        
        PersistentStorage.shared.saveContext()

    }
}
