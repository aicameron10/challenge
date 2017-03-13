//
//  MasterViewController.swift
//  challenge
//
//  Created by Andrew Cameron on 2017/03/10.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit
import CoreData
import DATAStack

class MasterViewController: UITableViewController,UISearchBarDelegate {
    
    var detailViewController: DetailViewController? = nil
    
    lazy var dataStack: DATAStack = DATAStack(modelName: "challenge")
    
    var items = [NSManagedObject]()
    var fields : Array<String> = Array()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    required init(dataStack: DATAStack) {
        
        super.init(nibName: nil, bundle: nil);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    var searchActive : Bool = false
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(fetchNewData), for: .valueChanged)
        
        self.fetchNewData()
        self.fetchCurrentObjects()
        
        searchBar.delegate = self
        
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = fields.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    func fetchNewData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.fetchPosts {_ in
            self.fetchCurrentObjects()
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
        
    }
    
    func fetchCurrentObjects() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        //print((try! dataStack.mainContext.fetch(request)))
        self.items = (try! dataStack.mainContext.fetch(request)) as! [NSManagedObject]
  
        self.tableView.reloadData()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = items[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.estimatedRowHeight = 44.0 // standard tableViewCell height
        tableView.rowHeight = UITableViewAutomaticDimension
        if(searchActive) {
            return filtered.count
        }
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var cell = CustomCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        cell.sizeToFit()
        cell.title.numberOfLines = 0
        cell.email.numberOfLines = 0
        
        
        if(searchActive){
            cell.title.text = filtered[indexPath.row]
            
        } else {
            let data = self.items[indexPath.row]
            cell.title.text = data.value(forKey: "title") as? String
            fields.append(cell.title.text!)
            cell.email.text = data.value(forKey: "body") as? String
            //cell.email.text = data.value(forAttributeDescription: "Users", usingRemoteValue: "email") as! String?
            
            //cell.email.text = data.value(forKey: "users") as! String?
        }
        
        
        //cell?.detailTextLabel?.text = data.user.username
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}

