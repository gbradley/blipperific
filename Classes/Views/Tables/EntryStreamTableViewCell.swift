//
//  EntryStreamTableViewCell.swift
//  Blipperific
//
//  Created by Graham on 26/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

protocol EntryStreamTableViewCellDelegate {
    
    func entryStreamTableViewCell(_ cell: EntryStreamTableViewCell, didTriggerAction action: String)
    
}

class EntryStreamTableViewCell : UITableViewCell {
    
    @IBOutlet var photoBackgroundView : PhotoBackgroundView!
    @IBOutlet var titleLabel : TitleLabel!
    @IBOutlet var mainImageView : UIButton!
    @IBOutlet var usernameLabel : TitleLabel!
    @IBOutlet var detailView : UIView!
    
    @IBOutlet var starButton : StatisticButton!
    @IBOutlet var favouriteButton : StatisticButton!
    @IBOutlet var commentButton : StatisticButton!
    @IBOutlet var viewCountLabel : StatisticLabel!
    @IBOutlet var starCountLabel : StatisticLabel!
    @IBOutlet var favouriteCountLabel : StatisticLabel!
    @IBOutlet var commentCountLabel : StatisticLabel!
    
    var delegate : EntryStreamTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layoutMargins.top = 30
        
        // Listen for theme changes
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateForTheme), name: .themeWasApplied, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Ensure a 5px spacing between the table cells.
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 5, 5, 5))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        titleLabel.isHidden = selected
        usernameLabel.isHidden = selected
        detailView.isHidden = !selected
        
        // Switching themes + selected cells can cause issues with backgrounds, so reset it here.
        if (!selected) {
            photoBackgroundView.backgroundColor = Theme.current!.photoBackgroundColor
        }
    }
    
    // Force background to update in respose to theme change.
    @objc func updateForTheme(notification : Notification) {
        let theme = notification.userInfo!["theme"] as! Theme
        if (self.isSelected) {
             photoBackgroundView.backgroundColor = UIColor.clear
             self.selectedBackgroundView?.backgroundColor = theme.selectedBackgroundColor
        } else {
             photoBackgroundView.backgroundColor = theme.photoBackgroundColor
        }
    }
   
    @IBAction func imageTapped(_ sender: Any) {
        self.delegate?.entryStreamTableViewCell(self, didTriggerAction: "entry")
    }
    
    @IBAction func statisticButtonTapped(_ sender: Any) {
        let button = sender as! UIButton
        if (!button.isSelected) {
            button.isSelected = true
            let action : String = ["star", "favourite", "comment"][button.tag]
            self.delegate?.entryStreamTableViewCell(self, didTriggerAction: action)
        }
    }
    
}

