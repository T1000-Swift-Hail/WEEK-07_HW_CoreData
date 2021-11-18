//
//  CDManage.swift
//  BookPhoneP
//
//  Created by Dalal AlSaidi on 13/04/1443 AH.
//

import Foundation
import CoreData

@objc(CDPhoneBook)
public class CDPhoneBook: NSManagedObject {

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: Int32
    
    func create(phone: PhoneBook) {

        let context = PersistentStorage.shared.context
        let cdManage = CDPhoneBook(context: context)
        cdManage.name = phone.name
        cdManage.phoneNumber  = phone.phoneNumber ?? 0
        
        PersistentStorage.shared.saveContext()

    }
}
