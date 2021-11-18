//
//  ContanctNames+CoreDataProperties.swift
//  H.W_CoreData
//
//  Created by Hesah Alqhtani on 18/11/2021.
//
//

import Foundation
import CoreData


extension ContanctNames {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContanctNames> {
        return NSFetchRequest<ContanctNames>(entityName: "ContanctNames")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNamber: String?

}

extension ContanctNames : Identifiable {

}
