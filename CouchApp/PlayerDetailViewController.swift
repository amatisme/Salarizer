//
//  PlayerDetailViewController.swift
//  CouchApp
//
//  Created by Lap on 2014-07-24.
//  Copyright (c) 2014 Lap. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    @IBOutlet var given_name : UILabel!
    
    var player: Player? {
        didSet {
            // Update the view.
            println(player)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println(player?.given_name)
        println(player?.image_name)
//        given_name.text = player!.given_name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
