//
//  ContactsFriends+CoreDataProperties.swift
//  PhoneBook
//
//  Created by Hind Alharbi on 11/18/21.
//
//

import Foundation
import CoreData


extension ContactsFriends {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactsFriends> {
        return NSFetchRequest<ContactsFriends>(entityName: "ContactsFriends")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var phone: String?

}

extension ContactsFriends : Identifiable {

}
