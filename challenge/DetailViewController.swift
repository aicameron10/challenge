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
    
    var indexOfExpandedCell = -1
    
    var ShowMoreLess = "closed"
    
    var shouldCellBeExpanded = false
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
                
                 titleLabel.text = detail.value(forKey: "title") as? String
                 body.text = detail.value(forKey: "body") as? String
            }
        }
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1 //However many static cells you want
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = DetailCustomCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCustomCell
        
        
        //cell.name.text = options[indexPath.row]
        
      
        
        if(shouldCellBeExpanded  && indexPath.row == indexOfExpandedCell)
        {

            //let type = cell.name.text!
 
            ShowMoreLess = "open"
         
            
        }else{
          
            ShowMoreLess = "closed"
        }
        

        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
     
        
        if(ShowMoreLess == "closed"){
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

