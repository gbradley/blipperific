//
//  StatisticButton.swift
//  Blipperific
//
//  Created by Graham on 02/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//
// This class is used for showing a button which updates entry statistics such as favourite or star.

import UIKit

class StatisticButton : UIButton {
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Switch the font depending on the button selection status.
        if (self.isSelected) {
            self.titleLabel?.font = UIFont.init(name: "FontAwesome5FreeSolid", size: 17);
        } else {
            self.titleLabel?.font = UIFont.init(name: "FontAwesome5FreeRegular", size: 17);
        }
    }
    
}
