//
//  PlayerTableViewController.swift
//  CouchApp
//
//  Created by Lap on 2014-07-22.
//  Copyright (c) 2014 Lap. All rights reserved.
//

import Foundation

import UIKit

class PlayerTableViewController: UITableViewController {
    
    var items = [AnyObject]()
    var detailItem: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let closure = {(data:[AnyObject]) -> () in
            self.items = data
            self.tableView.reloadData()
        }
        
        if let team = detailItem as? Team {
            Player.setObjectsWithTeamWithClosure(team.city!, { closure }())
            println(detailItem?.city)
        }
        else {
            println("Gonna load all players")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let object = items[indexPath.row] as Player
            (segue.destinationViewController as SecondViewController).detailItem = object
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
        var player : Player = self.items[indexPath.row] as Player
        if let given_name = player.given_name as String! {
            cell!.textLabel.text = given_name.capitalizedString
        }
        return cell
    }
}