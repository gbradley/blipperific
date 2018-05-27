//
//  EntryStreamViewController.swift
//  Blipperific
//
//  Created by Graham on 26/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit
import SDWebImage

class EntryStreamViewController : UIViewController, UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource, EntryStreamTableViewCellDelegate {
    
    @IBOutlet var entryTableView : UITableView!
    
    var shouldFetchMoreEntries : Bool! = true
    var entryResponses : [EntryResponse]
    
    private enum Section : Int {
        case Entries = 0
        case Pagination = 1
    }
    
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
        entryTableView.register(UINib(nibName: "EntryStreamPaginationViewCell", bundle:nil), forCellReuseIdentifier: "EntryStreamPaginationViewCell")
        
        // Hook up refresh control.
        entryTableView.refreshControl = UIRefreshControl()
        entryTableView.refreshControl?.addTarget(self, action: #selector(self.refreshEntries), for: .valueChanged)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + (shouldFetchMoreEntries ? 1 : 0);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int = 0
        if (section == Section.Entries.rawValue) {
            count = entryResponses.count
        } else if (section == Section.Pagination.rawValue) {
            count = 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height : CGFloat!
        if (indexPath.section == Section.Entries.rawValue) {
            // Determine the height based on the image's aspect ratio and the margins.
            let width = self.view.frame.size.width - 10
            let aspectRatio = entryResponses[indexPath.row].entry.image_aspect_ratio
            height = 40 + ((1.0 / CGFloat(aspectRatio!)) * width)
        } else if (indexPath.section == Section.Pagination.rawValue) {
            height = 30
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        if (indexPath.section == Section.Entries.rawValue) {
            cell = self.cellForEntryAt(indexPath)
        } else if (indexPath.section == Section.Pagination.rawValue) {
            cell = entryTableView!.dequeueReusableCell(withIdentifier: "EntryStreamPaginationViewCell")!
            cell.selectionStyle = .none
        }
        return cell
    }
    
    private func cellForEntryAt(_ indexPath : IndexPath) -> EntryStreamTableViewCell {
        let cell = entryTableView!.dequeueReusableCell(withIdentifier: "EntryStreamTableViewCell")! as! EntryStreamTableViewCell
        let entryResponse = entryResponses[indexPath.row]
        cell.configureFor(entryResponse)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        var path : IndexPath?
        if (indexPath.section == Section.Entries.rawValue) {
            let cell = tableView.cellForRow(at: indexPath)
            
            // Deselect the cell if it is already selected.
            if (cell?.isSelected)! {
                tableView.deselectRow(at: indexPath, animated: false)
            } else {
                
                // Load up details - this would trigger an ajax call and reload asynchronously.
                var entryResponse = entryResponses[indexPath.row]
                if (entryResponse.details == nil) {
                    let details = EntryDetails()
                    entryResponse.details = details
                    entryResponses[indexPath.row] = entryResponse
                    
                    // Pretend this in an ajax call.
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        if let cell = tableView.cellForRow(at: indexPath) {
                            (cell as! EntryStreamTableViewCell).configureFor(entryResponse)
                        }
                    }
                }
                path = indexPath
            }
        }
        return path
    }
    
    // Scroll view delegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        // Deselect any selected cell when the user drags the table.
        if let indexPath = entryTableView.indexPathForSelectedRow {
            entryTableView.deselectRow(at: indexPath, animated: false)
        }
    }

    // Table cell delegate
    func entryStreamTableViewCell(_ cell: EntryStreamTableViewCell, didTriggerAction action: String) {
        
        if let indexPath = entryTableView.indexPath(for: cell) {
        
            if (action == "entry") {
                if (cell.isSelected) {
                    entryTableView.deselectRow(at: indexPath, animated: false)
                }
                
                // Launch the entry controller.
                let entryViewController = EntryViewController(nibName: "EntryView", bundle: nil)
                self.presentJournalController(entryViewController)
                
            }
        }
    }
    
    // Refresh contol
    
    @objc func refreshEntries() {
        // Pretend this in an ajax call.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.entryTableView.refreshControl?.endRefreshing()
        }
    }
    
}
