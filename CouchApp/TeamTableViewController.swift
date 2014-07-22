//
//  TeamTableViewController.swift
//  CouchApp
//
//  Created by Lap on 2014-07-20.
//  Copyright (c) 2014 Lap. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController {
    
    var items = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let callbackMethod = {(data:[Team]) -> () in
            self.items = data
            self.tableView.reloadData()
            }
        Team.setAllTeams({ callbackMethod }())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let team = items[indexPath.row] as Team
            (segue.destinationViewController as SecondViewController).detailItem = team
        }
    }
    // testing comment for git
    
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
        var team : Team = self.items[indexPath.row]
        cell!.textLabel.text = team.city.capitalizedString + " " + team.name.capitalizedString
        cell!.detailTextLabel.text = team.conference.capitalizedString + " Conference, " + team.division.capitalizedString + " Division"
        return cell
    }
    
//    override func tableView(tableView: UITableView!, didDeselectRowAtIndexPath indexPath: NSIndexPath!) {
//        println("Selected cell at #\(indexPath.row)")
//    }
}
    
