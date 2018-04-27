//
//  BrowseTableCell.swift
//  Blipperific
//
//  Created by Graham on 26/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

class BrowseTableCell : UITableViewCell {
    
    @IBOutlet var label : UILabel!
    @IBOutlet private var entryCollectionView : UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    var collectionViewOffset: CGFloat {
        get {
            return entryCollectionView.contentOffset.x
        }
        set {
            entryCollectionView.contentOffset.x = newValue
        }
    }
    
    func setCollectionViewDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate> (dataSourceDelegate: D, forRow row: Int) {
        entryCollectionView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EntryCollectionViewCell")
        entryCollectionView.delegate = dataSourceDelegate
        entryCollectionView.dataSource = dataSourceDelegate
        entryCollectionView.tag = row
        entryCollectionView.reloadData()
    }
    
}
