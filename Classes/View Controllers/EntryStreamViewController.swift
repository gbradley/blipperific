//
//  EntryStreamViewController.swift
//  Blipperific
//
//  Created by Graham on 26/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit
import SDWebImage

class EntryStreamViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var entryTableView : UITableView!
    
    var entries : [Entry]
    
    init(nibName nibNameOrNil: String?, entries: [Entry], bundle nibBundleOrNil: Bundle?) {
        self.entries = entries
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.additionalSafeAreaInsets = UIEdgeInsets(top: 6, left: 0, bottom: 1, right: 0)
        entryTableView.register(UINib(nibName: "EntryTableCell", bundle:nil), forCellReuseIdentifier: "EntryTableCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = self.view.frame.size.width - 10
        let aspectRatio = entries[indexPath.row].image_aspect_ratio
        let height = 40 + ((1.0 / CGFloat(aspectRatio!)) * width)
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : EntryTableCell = entryTableView!.dequeueReusableCell(withIdentifier: "EntryTableCell")! as! EntryTableCell
        let entry = entries[indexPath.row]
        
        let url = URL(string: (entry.image_url))!
        
        cell.primaryImageView.sd_setImage(with: url, placeholderImage:nil)
        cell.usernameLabel.text = entry.username
        cell.titleLabel.text = entry.title
        
        return cell
    }
    
}
