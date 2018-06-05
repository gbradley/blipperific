//
//  EntyTableViewDescriptionCell.swift
//  Blipperific
//
//  Created by Graham on 05/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class EntryTableViewDescriptionCell : UITableViewCell {
    
    @IBOutlet var descriptionTextView : UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let currentTheme = Theme.current!
        descriptionTextView.textColor = currentTheme.textColor
        descriptionTextView.tintColor = currentTheme.buttonColor
        
        descriptionTextView.textContainerInset = UIEdgeInsets.zero
        descriptionTextView.textContainer.lineFragmentPadding = 5
    }
    
}
