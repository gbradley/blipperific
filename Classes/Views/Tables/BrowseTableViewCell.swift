//
//  BrowseTableViewCell.swift
//  Blipperific
//
//  Created by Graham on 26/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit



class BrowseTableViewCell : UITableViewCell {
    
    @IBOutlet var label : UILabel!
    @IBOutlet private var entryCollectionView : UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Switching themes + selected cells can cause issues with backgrounds, so reset it here.
        if (!selected) {
            entryCollectionView.backgroundColor = UIColor.clear
        }
    }
    
}
