//
//  Contact+CoreDataProperties.swift
//  PhoneBook_HW
//
//  Created by iAbdullah17 on 13/04/1443 AH.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}

extension Contact : Identifiable {

}
