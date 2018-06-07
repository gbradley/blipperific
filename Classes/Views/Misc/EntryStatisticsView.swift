//
//  EntryStatisticsView.swift
//  Blipperific
//
//  Created by Graham on 07/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class EntryStatisticsView : UIView {
    
    @IBOutlet var starButton : StatisticButton!
    @IBOutlet var favouriteButton : StatisticButton!
    @IBOutlet var commentButton : StatisticButton!
    @IBOutlet var viewCountLabel : StatisticLabel!
    @IBOutlet var starCountLabel : StatisticLabel!
    @IBOutlet var favouriteCountLabel : StatisticLabel!
    @IBOutlet var commentCountLabel : StatisticLabel!
    
    let actions = ["star", "favourite", "comment"]
    var actionTapped : ((_ action: String) -> Void)? = nil
    
    // Configure the cell for an entry response.
    func configureFor(_ entryResponse : EntryResponse) {
        
        // Configure the counts.
        if let details = entryResponse.details {
            viewCountLabel.text = details.views["total"]!.abbrevation()
            
            starCountLabel.text = details.stars["total"]!.abbrevation()
            starCountLabel.isUserInteractionEnabled = false
            starButton.isHighlighted = true
            starButton.isSelected = details.stars["starred"] == 1
            
            favouriteCountLabel.text = details.favourites["total"]!.abbrevation()
            favouriteCountLabel.isUserInteractionEnabled = false
            favouriteButton.isHighlighted = true
            favouriteButton.isSelected = details.favourites["favourited"] == 1
            
            commentCountLabel.text = details.comments["total"]!.abbrevation()
            commentCountLabel.isUserInteractionEnabled = false
            commentButton.isHighlighted = true
            commentButton.isSelected = false
            
            commentCountLabel.text = ""
        } else {
            viewCountLabel.text = ""
            
            starCountLabel.text = ""
            starCountLabel.isUserInteractionEnabled = true
            
            favouriteCountLabel.text = ""
            favouriteCountLabel.isUserInteractionEnabled = true
            
            commentCountLabel.text = ""
            favouriteCountLabel.isUserInteractionEnabled = true
            
            starButton.isSelected = false
            starButton.isHighlighted = false
            
            favouriteButton.isSelected = false
            favouriteButton.isHighlighted = false
            
            commentButton.isSelected = false
            commentButton.isHighlighted = false
        }
    }
    
    func onActionTapped(tapped: @escaping (_ action: String) -> Void) {
        self.actionTapped = tapped
    }
    
    // Inform the delegate when an action is requested.
    @IBAction func actionButtonTapped(_ sender: Any) {
        let button = sender as! UIButton
        let action : String = self.actions[button.tag]
        
        if (!button.isSelected) {
            button.isSelected = true
            self.actionTapped!(action)
        }
    }
    
}
