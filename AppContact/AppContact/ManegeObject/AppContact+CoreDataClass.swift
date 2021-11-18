//
//  AppContact+CoreDataClass.swift
//  AppContact
//
//  Created by Anas Hamad on 13/04/1443 AH.
//


import Foundation
import CoreData


@objc(CDNote)
public class CDNote: NSManagedObject {

    @NSManaged public var name: String?
    @NSManaged public var number: Int16
    
    func create(note: Note) {

        let context = PersistentStorage.shared.context
        let cdnote = CDNote(context: context)
        cdnote.name = note.name
        cdnote.number  = note.number ?? 0
        
        PersistentStorage.shared.saveContext()

    }
}
