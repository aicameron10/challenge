//
//  DetailViewController.swift
//  challenge
//
//  Created by Andrew Cameron on 2017/03/12.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit
import CoreData
import DATAStack


class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var body: UILabel!
    
    var items = [NSManagedObject]()
    
    lazy var dataStack: DATAStack = DATAStack(modelName: "challenge")
    
    var indexOfExpandedCell = -1
    
    var ShowMoreLess = false
    
    var userID = -1
    
    var albumID = -1
    
    var arrayAlbum = [AlbumStore]()
    
    
    var arrayPhotos = [String]()
    
    var shouldCellBeExpanded = false
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
                
                
                
                titleLabel.text = detail.value(forKey: "title") as? String
                body.text = detail.value(forKey: "body") as? String
                
                userID = (detail.value(forKey: "userId") as? Int)!
                
                fetchCurrentObjects()
            }
        }
    }
    
    required init(dataStack: DATAStack) {
        
        super.init(nibName: nil, bundle: nil);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var detailItem: NSManagedObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    
    func fetchCurrentObjects() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Albums")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
       
        self.items = (try! dataStack.mainContext.fetch(request)) as! [NSManagedObject]
       
        
        arrayAlbum.removeAll()
        
        for user in self.items as! [Albums] {
            if (user.userId == userID){
                let aar = AlbumStore()
                aar.id = user.id
                aar.title = user.title
                aar.userId = user.userId
                
                self.arrayAlbum.append(aar)
                
            }
        }
        
        self.tabelView.reloadData()
    }
    
    
    func fetchCurrentAlbumsPhotos() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Photos")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        self.items = (try! dataStack.mainContext.fetch(request)) as! [NSManagedObject]
        
        arrayPhotos.removeAll()
        
        for photo in self.items as! [Photos] {
            if (photo.albumId == albumID){
                
                
                self.arrayPhotos.append(photo.thumbnailUrl)
                
            }
            
        }
        
        
        let prefs = UserDefaults.standard
        
        prefs.set(self.arrayPhotos, forKey: "PhotoArray")
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if (arrayAlbum.isEmpty) {
            return 0
        } else {
            return arrayAlbum.count
        }
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = DetailCustomCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCustomCell
        
        let ar = arrayAlbum[indexPath.row]
        
        cell.albumName.text = ar.title
        
        
        
        if(shouldCellBeExpanded  && indexPath.row == indexOfExpandedCell)
        {
            
            //let type = cell.name.text!
            
            albumID = ar.id
            
            fetchCurrentAlbumsPhotos()
            
            ShowMoreLess = true
            
            
        }else{
            
            ShowMoreLess = false
        }
        
        
        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        
        if(ShowMoreLess == false){
            shouldCellBeExpanded = true
            
            indexOfExpandedCell = indexPath.row
            //print(indexOfEditCell)
            let indexPathNow = IndexPath(item: indexOfExpandedCell, section: 0)
            self.tabelView.beginUpdates()
            self.tabelView.reloadRows(at: [indexPathNow], with: .fade)
            self.tabelView.endUpdates()
            
            
        }else{
            
            shouldCellBeExpanded = false
            
            indexOfExpandedCell = indexPath.row
            //print(indexOfEditCell)
            let indexPathNow = IndexPath(item: indexOfExpandedCell, section: 0)
            self.tabelView.beginUpdates()
            self.tabelView.reloadRows(at: [indexPathNow], with: .fade)
            self.tabelView.endUpdates()
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(shouldCellBeExpanded  && indexPath.row == indexOfExpandedCell && indexPath.section == 0){
            
            return 300 //Your desired height for the expanded cell
        }else{
            return 44
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
class AlbumStore {
    var id = 0
    var userId = 0
    var title = ""
    
}


