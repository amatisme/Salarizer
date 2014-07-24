//
//  Player.swift
//  CouchApp
//
//  Created by Lap on 2014-07-22.
//  Copyright (c) 2014 Lap. All rights reserved.
//

import Foundation

class Player {
    
    var given_name : String?
    var image_name : String?
    
    init(data: Dictionary<String,AnyObject>) {
        given_name = data["given_name"]! as? String
        image_name = data["image_name"]! as? String
    }
    
    class func setObjectsWithTeamWithClosure(team: String,closure: ((data:[AnyObject]) -> ())?) {
        let url = NSURL(string: "http://127.0.0.1:5984/salarize/_design/api/_view/roster?key=%22\(team)%22&include_docs=true")
        setObjectsWithURLWithClosure(url, { closure }())
    }
    
    class func setObjectsWithURLWithClosure(url: NSURL, closure: ((data:[AnyObject]) -> ())?) {
        
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
                    var objects : [AnyObject] = []
                    for each : AnyObject in results {
                        if let doc = each["doc"]! as? Dictionary<String,AnyObject> {
                            var object = Player(data:doc)
                            objects.append(object)
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        closure!(data:objects)
                        })
                }
            }
            
            }).resume()
    }
    
}
