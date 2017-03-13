//
//  Albums.swift
//  challenge
//
//  Created by Andrew Cameron on 2017/03/12.
//  Copyright © 2017 Andrew. All rights reserved.
//

import Foundation
import CoreData

@objc(Albums)
class Albums: NSManagedObject {
    
    @NSManaged public var id: Int
    @NSManaged public var title: String
    @NSManaged public var userId: Int
    @NSManaged public var photos: NSSet
    @NSManaged public var user: User
    
}
