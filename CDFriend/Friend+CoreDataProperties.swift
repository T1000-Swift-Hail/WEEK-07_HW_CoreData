//
//  Friend+CoreDataProperties.swift
//  CDFriend
//
//  Created by AryafAlaqabali on 13/04/1443 AH.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}

extension Friend : Identifiable {

}
