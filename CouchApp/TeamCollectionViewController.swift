//
//  TeamCollectionViewController.swift
//  CouchApp
//
//  Created by Lap on 2014-07-23.
//  Copyright (c) 2014 Lap. All rights reserved.
//

import Foundation
import UIKit

class TeamCollectionViewController: UICollectionViewController {
    
    var items = [AnyObject]()
    
    override func viewDidLoad() {
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.delaysContentTouches = false
        
        let closure = {(data:[AnyObject]) -> () in
            self.items = data
            self.collectionView.reloadData()
        }
        Team.setObjectsWithConferenceWithClosure("eastern",{ closure }())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var cell  = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as TeamCollectionViewCell
        
        var team : Team = self.items[indexPath.row] as Team
        
        if let city = team.city as String! {
            if let name = team.name as String! {
                cell.textLabel.text = city.capitalizedString + " " + name.capitalizedString
            }
        }
        cell.imageView.image = UIImage(named: "220.jpg")
        return cell
    }
    
    // #pragma mark - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "showRoster" {
            let indexPath = collectionView.indexPathForCell(sender as UICollectionViewCell!)
            let team = items[indexPath.row] as Team
            (segue.destinationViewController as PlayerTableViewController).detailItem = team
        }
    }
    
}
