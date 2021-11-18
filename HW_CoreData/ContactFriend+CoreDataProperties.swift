//
//  ContactFriend+CoreDataProperties.swift
//  HW_CoreData
//
//  Created by Njoud Alrshidi on 13/04/1443 AH.
//
//

import Foundation
import CoreData


extension ContactFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactFriend> {
        return NSFetchRequest<ContactFriend>(entityName: "ContactFriend")
    }

    @NSManaged public var name: String?
      @NSManaged public var phoneNumber: String?
}

extension ContactFriend : Identifiable {

}
