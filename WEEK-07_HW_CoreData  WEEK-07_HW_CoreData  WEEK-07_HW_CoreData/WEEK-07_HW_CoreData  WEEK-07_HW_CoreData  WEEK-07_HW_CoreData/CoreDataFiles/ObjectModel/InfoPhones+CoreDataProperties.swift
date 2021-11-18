//
//  InfoPhones+CoreDataProperties.swift
//  WEEK-07_HW_CoreData  WEEK-07_HW_CoreData  WEEK-07_HW_CoreData
//
//  Created by mona aleid on 13/04/1443 AH.
//
//

import Foundation
import CoreData


extension InfoPhones {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InfoPhones> {
        return NSFetchRequest<InfoPhones>(entityName: "InfoPhones")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}

extension InfoPhones : Identifiable {

}
