//
//  BrowseViewController.swift
//  Blipperific
//
//  Created by Graham on 25/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//
// https://ashfurrow.com/blog/putting-a-uicollectionview-in-a-uitableviewcell-in-swift/

import UIKit

class BrowseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var browseTableView : UITableView!
    
    var storedOffsets = [Int: CGFloat]()
    
    var jsonString = "[{\"object\":\"Entry\",\"entry_id\":2435870928752608331,\"entry_id_str\":\"2435870928752608331\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"THE WHITE PONY\",\"username\":\"admirer\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/206dcb3a1ad9aa31c99ce7b2bf9b5cf79f57196a.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/206dcb3a1ad9aa31c99ce7b2bf9b5cf79f57196a.jpg\",\"image_aspect_ratio\":1.4953271},{\"object\":\"Entry\",\"entry_id\":2435712141261537599,\"entry_id_str\":\"2435712141261537599\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"Carpet of red tulips.\",\"username\":\"Farishta\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/650a5c3e92011bc1bcfe5894b4c6b1d25c3175ad.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/650a5c3e92011bc1bcfe5894b4c6b1d25c3175ad.jpg\",\"image_aspect_ratio\":1.5},{\"object\":\"Entry\",\"entry_id\":2436119873093371644,\"entry_id_str\":\"2436119873093371644\",\"date\":\"2018-04-26\",\"date_stamp\":1524700801,\"title\":\"A autumn \\\"roadie\\\"\",\"username\":\"rainie\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/20f52b8d30258c20ade736b3d2c31c7b2a5f986d.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/20f52b8d30258c20ade736b3d2c31c7b2a5f986d.jpg\",\"image_aspect_ratio\":1.5},{\"object\":\"Entry\",\"entry_id\":2435808330527016928,\"entry_id_str\":\"2435808330527016928\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"A Pair of Pigeons\",\"username\":\"evolybab\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/a58734422761119b30f4edadd725bd519668c3cc.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/a58734422761119b30f4edadd725bd519668c3cc.jpg\",\"image_aspect_ratio\":1.33333333},{\"object\":\"Entry\",\"entry_id\":2435346007005857842,\"entry_id_str\":\"2435346007005857842\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"He didn't...\",\"username\":\"WildMooseChase\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/164b254e165bba8ecb41612b2d4579acf696c1bb.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/164b254e165bba8ecb41612b2d4579acf696c1bb.jpg\",\"image_aspect_ratio\":1.86770428},{\"object\":\"Entry\",\"entry_id\":2436195511267492262,\"entry_id_str\":\"2436195511267492262\",\"date\":\"2018-04-26\",\"date_stamp\":1524700801,\"title\":\"Sunny Day\",\"username\":\"BobsBlips\",\"location\":{\"lat\":51.579202,\"lon\":-3.107978},\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/035a00fe06227387f038e4944c373ddf7c280cb6.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/035a00fe06227387f038e4944c373ddf7c280cb6.jpg\",\"image_aspect_ratio\":1.33518776},{\"object\":\"Entry\",\"entry_id\":2435529299659327252,\"entry_id_str\":\"2435529299659327252\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"The Family\",\"username\":\"EmmyHazyland\",\"location\":{\"lat\":55.526507,\"lon\":12.05831},\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/e1372feebaed859a2ff6a25c2ac22511eb7ef382.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/e1372feebaed859a2ff6a25c2ac22511eb7ef382.jpg\",\"image_aspect_ratio\":1.50706436},{\"object\":\"Entry\",\"entry_id\":2435384242675385077,\"entry_id_str\":\"2435384242675385077\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"\",\"username\":\"Markus_Hediger\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/2b596743af23f4c8c7088a62f08210750a3084d6.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/2b596743af23f4c8c7088a62f08210750a3084d6.jpg\",\"image_aspect_ratio\":1.50234742},{\"object\":\"Entry\",\"entry_id\":2435484634855768690,\"entry_id_str\":\"2435484634855768690\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Mandarin duck\",\"username\":\"pkln\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/badf4afacd8db6b1765c37e44c5924851e1a9198.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/badf4afacd8db6b1765c37e44c5924851e1a9198.jpg\",\"image_aspect_ratio\":1.28170895},{\"object\":\"Entry\",\"entry_id\":2435900110488472958,\"entry_id_str\":\"2435900110488472958\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"An actual Pot of Gold!\",\"username\":\"HeartFreek\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/fde2124df665929af43b8abccba30aa773a8992e.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/fde2124df665929af43b8abccba30aa773a8992e.jpg\",\"image_aspect_ratio\":1.77777778},{\"object\":\"Entry\",\"entry_id\":2435487695863023932,\"entry_id_str\":\"2435487695863023932\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Edibles\",\"username\":\"Miranda1008\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/73d9464e46d1ef003a725335abc15db332f87d6f.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/73d9464e46d1ef003a725335abc15db332f87d6f.jpg\",\"image_aspect_ratio\":1.46341463},{\"object\":\"Entry\",\"entry_id\":2435610023062143511,\"entry_id_str\":\"2435610023062143511\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Summer Sun\",\"username\":\"Hillyblips\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/b247300ebc5b3783b1fd7c392cc38e809e4e623a.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/b247300ebc5b3783b1fd7c392cc38e809e4e623a.jpg\",\"image_aspect_ratio\":1.08474576},{\"object\":\"Entry\",\"entry_id\":2435436363210818370,\"entry_id_str\":\"2435436363210818370\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Tiny Traveller\",\"username\":\"theBroon\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/e77f6a10eb2851cb5dd3635c9975be9bdbdd0b3b.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/e77f6a10eb2851cb5dd3635c9975be9bdbdd0b3b.jpg\",\"image_aspect_ratio\":1.5},{\"object\":\"Entry\",\"entry_id\":2435905312885048503,\"entry_id_str\":\"2435905312885048503\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"St Bathans.\",\"username\":\"richardg\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/94aa4c18f9fcbb3c1f0be78b9ced8057f79a634f.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/94aa4c18f9fcbb3c1f0be78b9ced8057f79a634f.jpg\",\"image_aspect_ratio\":1},{\"object\":\"Entry\",\"entry_id\":2435888787553780577,\"entry_id_str\":\"2435888787553780577\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"Stormont, Belfast\",\"username\":\"MShelley\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/ae721a1e76293cea893ce841bd2b97d7165158e8.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/ae721a1e76293cea893ce841bd2b97d7165158e8.jpg\",\"image_aspect_ratio\":1.74228675},{\"object\":\"Entry\",\"entry_id\":2436262929520134450,\"entry_id_str\":\"2436262929520134450\",\"date\":\"2018-04-26\",\"date_stamp\":1524700801,\"title\":\"Blipmeet at YSP\",\"username\":\"Freyjad\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/d97693addd2e5e05405fc4430637486c61fbcee7.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/d97693addd2e5e05405fc4430637486c61fbcee7.jpg\",\"image_aspect_ratio\":1.5},{\"object\":\"Entry\",\"entry_id\":2435555369238397291,\"entry_id_str\":\"2435555369238397291\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Low sun\",\"username\":\"martindawe\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/99ffcc04c709b1aae79ac8c7b0ecec23ff75a976.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/99ffcc04c709b1aae79ac8c7b0ecec23ff75a976.jpg\",\"image_aspect_ratio\":1.48606811},{\"object\":\"Entry\",\"entry_id\":2436162155079272108,\"entry_id_str\":\"2436162155079272108\",\"date\":\"2018-04-26\",\"date_stamp\":1524700801,\"title\":\"Eloise at the table\",\"username\":\"Barm_none\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/81f5c6bb36f5e056753522e3f411e09135cee59d.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/81f5c6bb36f5e056753522e3f411e09135cee59d.jpg\",\"image_aspect_ratio\":1},{\"object\":\"Entry\",\"entry_id\":2436010234951501689,\"entry_id_str\":\"2436010234951501689\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"Bathtime\",\"username\":\"Hillyblips\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/858f17d301b04f699dbc323844f5e73203e4b23e.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/858f17d301b04f699dbc323844f5e73203e4b23e.jpg\",\"image_aspect_ratio\":1.58415842},{\"object\":\"Entry\",\"entry_id\":2435547385087131957,\"entry_id_str\":\"2435547385087131957\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Cardiovascular disease\",\"username\":\"Marlieske\",\"location\":{\"lat\":51.673336,\"lon\":5.605753},\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/d81fb14258db8826dbbcbb00b4b8ef2e9f5de0ec.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/d81fb14258db8826dbbcbb00b4b8ef2e9f5de0ec.jpg\",\"image_aspect_ratio\":0.75}]"
    
    var entries : [Entry] = []
    
    var sections = [
        [
            "title" : "Recent"
        ],
        [
            "title" : "New"
        ],
        [
            "title" : "Following"
        ],
        [
            "title" : "Community"
        ],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hook up the browse table view and set its cells to use automatic height.
        self.browseTableView.register(UINib(nibName: "BrowseTableCell", bundle:nil), forCellReuseIdentifier: "BrowseTableCell")
        browseTableView.rowHeight = UITableViewAutomaticDimension
        browseTableView.estimatedRowHeight = 195
        
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        entries = try! decoder.decode([Entry].self, from: jsonData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if (browseTableView.indexPathForSelectedRow != nil) {
            browseTableView.deselectRow(at: browseTableView.indexPathForSelectedRow!, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ! Table data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BrowseTableCell = self.browseTableView!.dequeueReusableCell(withIdentifier: "BrowseTableCell")! as! BrowseTableCell
        cell.label.text = sections[indexPath.row]["title"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let browseTableCell = cell as? BrowseTableCell else { return }
        browseTableCell.backgroundColor = UIColor.clear
        browseTableCell.contentView.backgroundColor = UIColor.clear
        browseTableCell.selectionStyle = .none
        browseTableCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        browseTableCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let browseTableCell = cell as? BrowseTableCell else { return }
        storedOffsets[indexPath.row] = browseTableCell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entryStreamViewController = EntryStreamViewController.init(nibName: "EntryStreamView", entries: entries, bundle: nil)
        entryStreamViewController.title = sections[indexPath.row]["title"]
        self.navigationController?.pushViewController(entryStreamViewController, animated: true)
    }
    
    // Collection data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EntryCollectionViewCell", for: indexPath) as! EntryCollectionViewCell
        let entry = entries[indexPath.row]
        
        let url = URL(string: entry.thumbnail_url)!
        cell.primaryImageView.sd_setImage(with: url, placeholderImage:nil)
        return cell
    }
    
}

