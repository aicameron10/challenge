//
//  AppDelegate.swift
//  challenge
//
//  Created by Andrew Cameron on 2017/03/10.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit
import CoreData
import DATAStack
import Alamofire
import Sync

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    lazy var dataStack: DATAStack = DATAStack(modelName: "challenge")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        
        splitViewController.delegate = self
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        fetchPosts { _ in
        }
        fetchUsers { _ in
        }
        fetchPhotos { _ in
        }
        fetchAlbums { _ in
        }
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    
    public func fetchUsers(_ completion: @escaping (NSError?) -> Void)  {
        
        let urlString: String
        
        urlString = Constants.Users
        
        AppDelegate.Manager.request(urlString, method: .get).responseJSON { response in
            
            if let jsonResponse = response.result.value {
                
                let responseJ = jsonResponse
                
                
                let json = JSON(responseJ as Any)
                
                let k = "{\"data\":" + json.rawString()! + "}"
                
                let dict = self.convertToDictionary(text: k)
                
                //print(dict?["data"] as! [[String : Any]])
                
                Sync.changes(dict?["data"] as! [[String : Any]], inEntityNamed: "Users", dataStack: self.dataStack) { error in
                    completion(error)
                }
                
                
            }
            
            
        }
    }
    
    public func fetchAlbums(_ completion: @escaping (NSError?) -> Void)  {
        
        let urlString: String
        
        urlString = Constants.Albums

        AppDelegate.Manager.request(urlString, method: .get).responseJSON { response in
            
            if let jsonResponse = response.result.value {
                
                let responseJ = jsonResponse
                
                let json = JSON(responseJ as Any)
                
                let k = "{\"data\":" + json.rawString()! + "}"
                
                let dict = self.convertToDictionary(text: k)
                
                //print(dict?["data"] as! [[String : Any]])
                
                Sync.changes(dict?["data"] as! [[String : Any]], inEntityNamed: "Albums", dataStack: self.dataStack) { error in
                    completion(error)
                }
                
                
            }
            
            
        }
    }
    
    public func fetchPosts(_ completion: @escaping (NSError?) -> Void)  {
        
        let urlString: String
        
        urlString = Constants.Posts
        
        AppDelegate.Manager.request(urlString, method: .get).responseJSON { response in
            
            if let jsonResponse = response.result.value {
                
                let responseJ = jsonResponse
                
                
                let json = JSON(responseJ as Any)
                
                let k = "{\"data\":" + json.rawString()! + "}"
                
                let dict = self.convertToDictionary(text: k)
                
                //print(dict?["data"] as! [[String : Any]])
                
                Sync.changes(dict?["data"] as! [[String : Any]], inEntityNamed: "Posts", dataStack: self.dataStack) { error in
                    completion(error)
                }
                
                
            }
            
            
        }
    }
    
    public func fetchPhotos(_ completion: @escaping (NSError?) -> Void)  {
        
        let urlString: String
        
        urlString = Constants.Photos
        
        AppDelegate.Manager.request(urlString, method: .get).responseJSON { response in
            
            if let jsonResponse = response.result.value {
                
                let responseJ = jsonResponse
                
                
                let json = JSON(responseJ as Any)
                
                let k = "{\"data\":" + json.rawString()! + "}"
                
                let dict = self.convertToDictionary(text: k)
                
                //print(dict?["data"] as! [[String : Any]])
                
                Sync.changes(dict?["data"] as! [[String : Any]], inEntityNamed: "Photos", dataStack: self.dataStack) { error in
                    completion(error)
                }
                
                
            }
            
            
        }
    }
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    private static var Manager: Alamofire.SessionManager = {
        
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()
    
    
}

