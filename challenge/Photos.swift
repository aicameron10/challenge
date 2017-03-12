//
//  Photos.swift
//  challenge
//
//  Created by Andrew Cameron on 2017/03/12.
//  Copyright © 2017 Andrew. All rights reserved.
//

import Foundation
import CoreData

@objc(Photos)
class Photos: NSManagedObject {
    
    @NSManaged public var albumId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var thumbnailUrl: String
    @NSManaged public var title: String
    @NSManaged public var url: String
    @NSManaged public var albums: Albums
    
}
