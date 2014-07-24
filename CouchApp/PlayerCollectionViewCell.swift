//
//  PlayerCollectionViewCell.swift
//  CouchApp
//
//  Created by Lap on 2014-07-24.
//  Copyright (c) 2014 Lap. All rights reserved.
//

import Foundation
import UIKit

class PlayerCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var textLabel : UILabel!
    @IBOutlet var detailButton : UIButton!
    
    init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
}
