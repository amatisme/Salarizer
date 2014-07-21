//
//  TeamTableViewController.swift
//  CouchApp
//
//  Created by Lap on 2014-07-20.
//  Copyright (c) 2014 Lap. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setAllTeams()
        println(items)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }
        var team : Team = self.items[indexPath.row]
        cell!.textLabel.text = team.conference
//        cell!.detailTextLabel.text = "test"
        return cell
    }
    
    override func tableView(tableView: UITableView!, didDeselectRowAtIndexPath indexPath: NSIndexPath!) {
        println("Selected cell at #\(indexPath.row)")
    }
    
    func setAllTeams() {
        let url = NSURL(string: "http://127.0.0.1:5984/salarize/_design/api/_view/teams?include_docs=true")
        var session = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(url, completionHandler:{(data: NSData!,
            response: NSURLResponse!,
            error: NSError!) in
            
            if error {
                println("API Error: \(error), \(error.userInfo)")
            }
            var jsonError: NSError?
            var json : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            if jsonError {
                println("Error parsing json: \(jsonError)")
            }
            else {
                let results : NSArray = json["rows"] as NSArray
                    if results.count > 0 {
                        var teams : [Team] = []
                        for each : AnyObject in results {
                            if let dict = each["doc"] as? Dictionary<String,String> {
                                var team = Team(dict: dict)
                                teams.append(team)
                            }
                        }
                        dispatch_async(dispatch_get_main_queue(), {
                            println("hello from UI thread executed as dispatch")
                            self.items  = teams
                            println(self.items)
                            self.tableView.reloadData()
                            })
                    }
            }
            
        }).resume()
        println(items)
    }
}
    
