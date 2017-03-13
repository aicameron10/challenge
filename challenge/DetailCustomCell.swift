//
//  DetailCustomCell.swift
//  challenge
//
//  Created by Andrew Cameron on 2017/03/12.
//  Copyright © 2017 Andrew. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
class DetailCustomCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collect: UICollectionView!
    
    @IBOutlet weak var albumName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpTable()
        
        
    }
    
    var arrayPhotos = [String]()
    
    func setUpTable()
    {
        collect?.delegate = self
        collect?.dataSource = self
        let prefs = UserDefaults.standard
        if (prefs.object(forKey: "PhotoArray") != nil){
            
            arrayPhotos = prefs.object(forKey: "PhotoArray") as! [String]
            
        }
        
    }
    
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if (arrayPhotos.isEmpty) {
            return 0
        } else {
            return arrayPhotos.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let aUrl = arrayPhotos[indexPath.row]
        let url = URL(string: aUrl)
        
        
        cell.cellImageView.kf.setImage(with: url)
        
        
        return cell
    }
}

