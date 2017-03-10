import Foundation
import CoreData

@objc(Albums)
class Album: NSManagedObject {
    @NSManaged var text: String
    @NSManaged var id: String
    @NSManaged var createdAt: TimeInterval
    @NSManaged var user: User
    
}
