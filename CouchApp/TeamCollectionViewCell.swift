//
//  TeamCollectionViewCell.swift
//  CouchApp
//
//  Created by Lap on 2014-07-23.
//  Copyright (c) 2014 Lap. All rights reserved.
//

import Foundation
import UIKit

class TeamCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var textLabel : UILabel!
    
    init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

}