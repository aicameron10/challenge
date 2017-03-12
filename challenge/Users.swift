import Foundation
import CoreData

@objc(Users)
class Users: NSManagedObject {
    @NSManaged public var address: NSData
    @NSManaged public var company: NSData
    @NSManaged public var email: String
    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var username: String
    @NSManaged public var website: String
    @NSManaged public var albums: NSSet
    @NSManaged public var posts: NSSet
    
}
