//
//  EntryTableViewTitleCell.swift
//  Blipperific
//
//  Created by Graham on 05/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class EntryTableViewTitleCell : UITableViewCell {
    
    @IBOutlet var titleLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let currentTheme = Theme.current!
        titleLabel.font = UIFont(name: currentTheme.userTextFontName, size: 15)
        titleLabel.textColor = currentTheme.headingColor
    }
    
}
