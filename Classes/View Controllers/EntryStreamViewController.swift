//
//  EntryStreamViewController.swift
//  Blipperific
//
//  Created by Graham on 26/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit
import SDWebImage

class EntryStreamViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, EntryStreamTableViewCellDelegate {
    
    @IBOutlet var entryTableView : UITableView!
    
    var entryResponses : [EntryResponse]
    
    init(nibName nibNameOrNil: String?, entryResponses: [EntryResponse], bundle nibBundleOrNil: Bundle?) {
        self.entryResponses = entryResponses
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCustomBackButton()
        
        self.additionalSafeAreaInsets = UIEdgeInsets(top: 6, left: 0, bottom: 1, right: 0)
        entryTableView.register(UINib(nibName: "EntryStreamTableViewCell", bundle:nil), forCellReuseIdentifier: "EntryStreamTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryResponses.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Determine the height based on the image's aspect ratio and the margins.
        let width = self.view.frame.size.width - 10
        let aspectRatio = entryResponses[indexPath.row].entry.image_aspect_ratio
        let height = 40 + ((1.0 / CGFloat(aspectRatio!)) * width)
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : EntryStreamTableViewCell = entryTableView!.dequeueReusableCell(withIdentifier: "EntryStreamTableViewCell")! as! EntryStreamTableViewCell
        let entryResponse = entryResponses[indexPath.row]
        let entry = entryResponse.entry
        
        let url = URL(string: (entry.image_url))!
        
        // Configure the image and its labels.
        cell.mainImageView.sd_setImage(with: url, for: .normal)
        cell.usernameLabel.text = entry.username
        cell.titleLabel.text = entry.title
        
        // Configure the counts.
        if let details = entryResponse.details {
            cell.viewCountLabel.text = details.views["total"]!.abbrevation()
            
            cell.starCountLabel.text = details.stars["total"]!.abbrevation()
            cell.starCountLabel.isUserInteractionEnabled = false
            cell.starButton.isHighlighted = true
            cell.starButton.isSelected = details.stars["starred"] == 1
            
            cell.favouriteCountLabel.text = details.favourites["total"]!.abbrevation()
            cell.favouriteCountLabel.isUserInteractionEnabled = false
            cell.favouriteButton.isHighlighted = true
            cell.favouriteButton.isSelected = details.favourites["favourited"] == 1
            
            cell.commentCountLabel.text = details.comments["total"]!.abbrevation()
            cell.commentCountLabel.isUserInteractionEnabled = false
            cell.commentButton.isHighlighted = true
            cell.commentButton.isSelected = false
            
            cell.commentCountLabel.text = ""
        } else {
            cell.viewCountLabel.text = ""

            cell.starCountLabel.text = ""
            cell.starCountLabel.isUserInteractionEnabled = true

            cell.favouriteCountLabel.text = ""
            cell.favouriteCountLabel.isUserInteractionEnabled = true
            
            cell.commentCountLabel.text = ""
            cell.favouriteCountLabel.isUserInteractionEnabled = true
            
            cell.starButton.isSelected = false
            cell.starButton.isHighlighted = false
            
            cell.favouriteButton.isSelected = false
            cell.favouriteButton.isHighlighted = false
            
            cell.commentButton.isSelected = false
            cell.commentButton.isHighlighted = false
        }
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        
        // Deselect the cell if it is already selected.
        if (cell?.isSelected)! {
            tableView.deselectRow(at: indexPath, animated: false)
            return nil
        } else {
            
            // Load up details - this would trigger an ajax call and reload asynchronously.
            var entryResponse = entryResponses[indexPath.row]
            if (entryResponse.details == nil) {
                let details = EntryDetails()
                entryResponse.details = details
                entryResponses[indexPath.row] = entryResponse
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        return indexPath
    }
    
    // Table cell delegate
    func entryStreamTableViewCell(_ cell: EntryStreamTableViewCell, didTriggerAction action: String) {
        
        if let indexPath = entryTableView.indexPath(for: cell) {
        
            if (action == "entry") {
                if (cell.isSelected) {
                    entryTableView.deselectRow(at: indexPath, animated: false)
                }
            }
        }
    }
    
}
