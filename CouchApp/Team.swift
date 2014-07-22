//
//  Team.swift
//  CouchApp
//
//  Created by Lap on 2014-07-21.
//  Copyright (c) 2014 Lap. All rights reserved.
//
import Foundation

class Team {
    
    var type : String
    var city : String
    var name : String
    var location : String
    var division : String
    var conference : String
    
    init(dict: Dictionary<String,String>) {
        type = dict["type"] as String
        city = dict["city"] as String
        name = dict["name"] as String
        location = dict["location"] as String
        division = dict["division"] as String
        conference = dict["conference"] as String
    }
    
    class func setAllTeams(callback: ((data:[Team]) -> ())?) {
        let url = NSURL(string: "http://127.0.0.1:5984/salarize/_design/api/_view/teams?include_docs=true")
        var session = NSURLSession.sharedSession()
        var items : [Team] = []
        
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
                        callback!(data:teams)
//                        self.callback(Array: teams)
                        
//                        self.items  = teams
//                        self.tableView.reloadData()
                        })
                }
            }
            
            }).resume()
    }
    
}
