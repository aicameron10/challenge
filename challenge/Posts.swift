//
//  Posts.swift
//  challenge
//
//  Created by Andrew Cameron on 2017/03/12.
//  Copyright © 2017 Andrew. All rights reserved.
//
import Foundation
import CoreData

@objc(Posts)
class Posts: NSManagedObject {
    
    @NSManaged public var body: String
    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var userId: Int64
    @NSManaged public var user: User
    
}
