//
//  CDFriend+coreData.swift
//  CoreDataHW
//
//  Created by MACBOOK on 13/04/1443 AH.
//

import Foundation

import CoreData

@objc(CDFriend)
public class CDFriend: NSManagedObject {

    @NSManaged public var nameFriend: String?
    @NSManaged public var phonNumber: Int16
    
    func create(friend: Friend) {

        let context = FriendStorage.shared.context
        let CDFriend = CDFriend(context: context)
        CDFriend.nameFriend = friend.nameFrind
        CDFriend.phonNumber  = friend.phonNumber ?? 0
        
        FriendStorage.shared.saveContext()

    }
}

