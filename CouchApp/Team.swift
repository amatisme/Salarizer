//
//  Team.swift
//  CouchApp
//
//  Created by Lap on 2014-07-21.
//  Copyright (c) 2014 Lap. All rights reserved.
//

class Team {
    
    var type : String?
    var city : String?
    var name : String?
    var location : String?
    var division : String?
    var conference : String?
    
    init(dict: Dictionary<String,String>) {
        type = dict["type"] as? String
        city = dict["city"] as? String
        name = dict["name"] as? String
        location = dict["location"] as? String
        division = dict["division"] as? String
        conference = dict["conference"] as? String
    }
    
}
