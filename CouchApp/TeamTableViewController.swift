//
//  TeamTableViewController.swift
//  CouchApp
//
//  Created by Lap on 2014-07-20.
//  Copyright (c) 2014 Lap. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController {
    
    var items = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let closure = {(data:[AnyObject]) -> () in
            self.items = data
            self.tableView.reloadData()
            }
        Team.setObjectsWithConferenceWithClosure("eastern",{ closure }())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRoster" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let team = items[indexPath.row] as Team
            (segue.destinationViewController as PlayerTableViewController).detailItem = team
        }
    }
    
    // #pragma mark - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:UITableViewCell? = self.tableView?.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        }
        var team : Team = self.items[indexPath.row] as Team
        if let city = team.city as? String {
            if let name = team.name as? String {
                cell!.textLabel.text = city.capitalizedString + " " + name.capitalizedString
            }
        }
        if let conference = team.conference as? String {
            if let division = team.division as? String {
                cell!.detailTextLabel.text = conference.capitalizedString + " Conference, " + division.capitalizedString + " Division"
            }
        }
        
        return cell
    }
}
    
