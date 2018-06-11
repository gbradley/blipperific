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
    @IBOutlet var usernameButton : UIButton!
    @IBOutlet var statisticsContainerView : UIView!
    var statisticsView : EntryStatisticsView!
    
    let actions : [String]! = ["entry", "journal"]
    
    var delegate : EntryStreamTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layoutMargins.top = 30
        
        // Listen for theme changes
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateForTheme), name: .themeWasApplied, object: nil)
        
        // Add the statistics view.
        self.statisticsView = Bundle.main.loadNibNamed("EntryStatisticsView", owner: self, options: nil)![0] as! EntryStatisticsView
        self.statisticsView.frame = CGRect(x: 0, y: 0, width: statisticsContainerView.frame.size.width, height: statisticsContainerView.frame.size.height)
        statisticsContainerView.addSubview(self.statisticsView)
        self.statisticsView.onActionTapped { (action) in
            self.delegate?.entryStreamTableViewCell(self, didTriggerAction: action)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Ensure a 5px spacing between the table cells.
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 5, 5, 5))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        titleLabel.isHidden = selected
        usernameButton.isHidden = selected
        statisticsContainerView.isHidden = !selected
        
        // Switching themes + selected cells can cause issues with backgrounds, so reset it here.
        if (!selected) {
            photoBackgroundView.backgroundColor = Theme.current!.photoBackgroundColor
        }
    }
    
    func configureFor(_ response : EntryResponse) {
        
        let entry = response.entry
        let url = URL(string: (entry.image_url))!
        
        // Configure the image and its labels.
        mainImageView.sd_setImage(with: url, for: .normal)
        usernameButton.setTitle(entry.username, for: .normal)
        titleLabel.text = entry.title
        
        self.statisticsView.configureFor(response)
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
    
    // Inform the delegate when an action is requested.
    @IBAction func actionButtonTapped(_ sender: Any) {
        let button = sender as! UIButton
        let action : String = self.actions[button.tag]
        let selectable = false
        
        if (!selectable || !button.isSelected) {
            button.isSelected = selectable
            self.delegate?.entryStreamTableViewCell(self, didTriggerAction: action)
        }
    }
    
}


