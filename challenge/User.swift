import Foundation
import CoreData

@objc(Users)
class User: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var email: String
    @NSManaged var address: String
    @NSManaged var phone: String
    @NSManaged var website: String
    @NSManaged var company: String
    
    
}
