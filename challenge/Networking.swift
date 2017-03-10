//
//  Constants.swift
//
//  Created by Andrew Cameron
//  Copyright © 2017. All rights reserved.
//

import UIKit
import DATAStack
import Sync
import Alamofire

class Networking: NSObject {
    let postsURL = Constants.Posts
    let usersURL = Constants.Users
    let albumsURL = Constants.Albums
    let photosURL = Constants.Photos
    let dataStack: DATAStack

    required init(dataStack: DATAStack) {
        self.dataStack = dataStack
    }

    func fetchPosts(_ completion: @escaping (NSError?) -> Void) {
        Alamofire.request(postsURL).responseJSON { response in
            let data = response.result.value as! [String : Any]

            Sync.changes(data["data"] as! [[String : Any]], inEntityNamed: "Data", dataStack: self.dataStack) { error in
                completion(error)
            }
        }
    }
    
    func fetchUsers(_ completion: @escaping (NSError?) -> Void) {
        Alamofire.request(usersURL).responseJSON { response in
            let data = response.result.value as! [String : Any]
            
            Sync.changes([data], inEntityNamed: "Users", dataStack: self.dataStack) { error in
                completion(error)
            }
        }
    }

    
    func fetchAlbums(_ completion: @escaping (NSError?) -> Void) {
        Alamofire.request(albumsURL).responseJSON { response in
            let data = response.result.value as! [String : Any]
            
            Sync.changes(data["data"] as! [[String : Any]], inEntityNamed: "Data", dataStack: self.dataStack) { error in
                completion(error)
            }
        }
    }

    func fetchPhotos(_ completion: @escaping (NSError?) -> Void) {
        Alamofire.request(photosURL).responseJSON { response in
            let data = response.result.value as! [String : Any]
            
            Sync.changes(data["data"] as! [[String : Any]], inEntityNamed: "Data", dataStack: self.dataStack) { error in
                completion(error)
            }
        }
    }


    
    func changeNotification(_ notification: Notification) {
        let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey]
        let deletedObjects = notification.userInfo?[NSDeletedObjectsKey]
        let insertedObjects = notification.userInfo?[NSInsertedObjectsKey]
        print("updatedObjects: \(updatedObjects)")
        print("deletedObjects: \(deletedObjects)")
        print("insertedObjects: \(insertedObjects)")
    }
}
