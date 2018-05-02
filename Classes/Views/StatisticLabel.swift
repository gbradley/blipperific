//
//  StatisticLabel.swift
//  Blipperific
//
//  Created by Graham on 02/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class StatisticLabel : UILabel {
    
    var edgeInsets : UIEdgeInsets!
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        self.edgeInsets = UIEdgeInsetsMake(0, 27, 0, 0)
        self.isExclusiveTouch = true
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, self.edgeInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width  += self.edgeInsets.left + self.edgeInsets.right;
        size.height += self.edgeInsets.top + self.edgeInsets.bottom;
        return size;
    }*/
    
}
