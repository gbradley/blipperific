//
//  EntryTableCell.swift
//  Blipperific
//
//  Created by Graham on 26/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class EntryTableCell : UITableViewCell {
    
    @IBOutlet var primaryImageView : UIImageView!
    @IBOutlet var usernameLabel : TitleLabel!
    @IBOutlet var titleLabel : TitleLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
}

