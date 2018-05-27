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
    
    /*var jsonString = "[{\"object\":\"Entry\",\"entry_id\":2435870928752608331,\"entry_id_str\":\"2435870928752608331\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"THE WHITE PONY This is a really long title\",\"username\":\"admirer\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/206dcb3a1ad9aa31c99ce7b2bf9b5cf79f57196a.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/206dcb3a1ad9aa31c99ce7b2bf9b5cf79f57196a.jpg\",\"image_aspect_ratio\":1.4953271},{\"object\":\"Entry\",\"entry_id\":2435712141261537599,\"entry_id_str\":\"2435712141261537599\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"Carpet of red tulips.\",\"username\":\"Farishta\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/650a5c3e92011bc1bcfe5894b4c6b1d25c3175ad.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/650a5c3e92011bc1bcfe5894b4c6b1d25c3175ad.jpg\",\"image_aspect_ratio\":1.5},{\"object\":\"Entry\",\"entry_id\":2436119873093371644,\"entry_id_str\":\"2436119873093371644\",\"date\":\"2018-04-26\",\"date_stamp\":1524700801,\"title\":\"A autumn \\\"roadie\\\"\",\"username\":\"rainie\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/20f52b8d30258c20ade736b3d2c31c7b2a5f986d.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/20f52b8d30258c20ade736b3d2c31c7b2a5f986d.jpg\",\"image_aspect_ratio\":1.5},{\"object\":\"Entry\",\"entry_id\":2435808330527016928,\"entry_id_str\":\"2435808330527016928\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"A Pair of Pigeons\",\"username\":\"evolybab\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/a58734422761119b30f4edadd725bd519668c3cc.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/a58734422761119b30f4edadd725bd519668c3cc.jpg\",\"image_aspect_ratio\":1.33333333},{\"object\":\"Entry\",\"entry_id\":2435346007005857842,\"entry_id_str\":\"2435346007005857842\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"He didn't...\",\"username\":\"WildMooseChase\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/164b254e165bba8ecb41612b2d4579acf696c1bb.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/164b254e165bba8ecb41612b2d4579acf696c1bb.jpg\",\"image_aspect_ratio\":1.86770428},{\"object\":\"Entry\",\"entry_id\":2436195511267492262,\"entry_id_str\":\"2436195511267492262\",\"date\":\"2018-04-26\",\"date_stamp\":1524700801,\"title\":\"Sunny Day\",\"username\":\"BobsBlips\",\"location\":{\"lat\":51.579202,\"lon\":-3.107978},\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/035a00fe06227387f038e4944c373ddf7c280cb6.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/035a00fe06227387f038e4944c373ddf7c280cb6.jpg\",\"image_aspect_ratio\":1.33518776},{\"object\":\"Entry\",\"entry_id\":2435529299659327252,\"entry_id_str\":\"2435529299659327252\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"The Family\",\"username\":\"EmmyHazyland\",\"location\":{\"lat\":55.526507,\"lon\":12.05831},\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/e1372feebaed859a2ff6a25c2ac22511eb7ef382.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/e1372feebaed859a2ff6a25c2ac22511eb7ef382.jpg\",\"image_aspect_ratio\":1.50706436},{\"object\":\"Entry\",\"entry_id\":2435384242675385077,\"entry_id_str\":\"2435384242675385077\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"\",\"username\":\"Markus_Hediger\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/2b596743af23f4c8c7088a62f08210750a3084d6.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/2b596743af23f4c8c7088a62f08210750a3084d6.jpg\",\"image_aspect_ratio\":1.50234742},{\"object\":\"Entry\",\"entry_id\":2435484634855768690,\"entry_id_str\":\"2435484634855768690\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Mandarin duck\",\"username\":\"pkln\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/badf4afacd8db6b1765c37e44c5924851e1a9198.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/badf4afacd8db6b1765c37e44c5924851e1a9198.jpg\",\"image_aspect_ratio\":1.28170895},{\"object\":\"Entry\",\"entry_id\":2435900110488472958,\"entry_id_str\":\"2435900110488472958\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"An actual Pot of Gold!\",\"username\":\"HeartFreek\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/fde2124df665929af43b8abccba30aa773a8992e.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/fde2124df665929af43b8abccba30aa773a8992e.jpg\",\"image_aspect_ratio\":1.77777778},{\"object\":\"Entry\",\"entry_id\":2435487695863023932,\"entry_id_str\":\"2435487695863023932\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Edibles\",\"username\":\"Miranda1008\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/73d9464e46d1ef003a725335abc15db332f87d6f.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/73d9464e46d1ef003a725335abc15db332f87d6f.jpg\",\"image_aspect_ratio\":1.46341463},{\"object\":\"Entry\",\"entry_id\":2435610023062143511,\"entry_id_str\":\"2435610023062143511\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Summer Sun\",\"username\":\"Hillyblips\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/b247300ebc5b3783b1fd7c392cc38e809e4e623a.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/b247300ebc5b3783b1fd7c392cc38e809e4e623a.jpg\",\"image_aspect_ratio\":1.08474576},{\"object\":\"Entry\",\"entry_id\":2435436363210818370,\"entry_id_str\":\"2435436363210818370\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Tiny Traveller\",\"username\":\"theBroon\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/e77f6a10eb2851cb5dd3635c9975be9bdbdd0b3b.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/e77f6a10eb2851cb5dd3635c9975be9bdbdd0b3b.jpg\",\"image_aspect_ratio\":1.5},{\"object\":\"Entry\",\"entry_id\":2435905312885048503,\"entry_id_str\":\"2435905312885048503\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"St Bathans.\",\"username\":\"richardg\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/94aa4c18f9fcbb3c1f0be78b9ced8057f79a634f.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/94aa4c18f9fcbb3c1f0be78b9ced8057f79a634f.jpg\",\"image_aspect_ratio\":1},{\"object\":\"Entry\",\"entry_id\":2435888787553780577,\"entry_id_str\":\"2435888787553780577\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"Stormont, Belfast\",\"username\":\"MShelley\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/ae721a1e76293cea893ce841bd2b97d7165158e8.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/ae721a1e76293cea893ce841bd2b97d7165158e8.jpg\",\"image_aspect_ratio\":1.74228675},{\"object\":\"Entry\",\"entry_id\":2436262929520134450,\"entry_id_str\":\"2436262929520134450\",\"date\":\"2018-04-26\",\"date_stamp\":1524700801,\"title\":\"Blipmeet at YSP\",\"username\":\"Freyjad\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/d97693addd2e5e05405fc4430637486c61fbcee7.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/d97693addd2e5e05405fc4430637486c61fbcee7.jpg\",\"image_aspect_ratio\":1.5},{\"object\":\"Entry\",\"entry_id\":2435555369238397291,\"entry_id_str\":\"2435555369238397291\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Low sun\",\"username\":\"martindawe\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/99ffcc04c709b1aae79ac8c7b0ecec23ff75a976.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/99ffcc04c709b1aae79ac8c7b0ecec23ff75a976.jpg\",\"image_aspect_ratio\":1.48606811},{\"object\":\"Entry\",\"entry_id\":2436162155079272108,\"entry_id_str\":\"2436162155079272108\",\"date\":\"2018-04-26\",\"date_stamp\":1524700801,\"title\":\"Eloise at the table\",\"username\":\"Barm_none\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/81f5c6bb36f5e056753522e3f411e09135cee59d.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/81f5c6bb36f5e056753522e3f411e09135cee59d.jpg\",\"image_aspect_ratio\":1},{\"object\":\"Entry\",\"entry_id\":2436010234951501689,\"entry_id_str\":\"2436010234951501689\",\"date\":\"2018-04-25\",\"date_stamp\":1524614401,\"title\":\"Bathtime\",\"username\":\"Hillyblips\",\"location\":null,\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/858f17d301b04f699dbc323844f5e73203e4b23e.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/858f17d301b04f699dbc323844f5e73203e4b23e.jpg\",\"image_aspect_ratio\":1.58415842},{\"object\":\"Entry\",\"entry_id\":2435547385087131957,\"entry_id_str\":\"2435547385087131957\",\"date\":\"2018-04-24\",\"date_stamp\":1524528001,\"title\":\"Cardiovascular disease\",\"username\":\"Marlieske\",\"location\":{\"lat\":51.673336,\"lon\":5.605753},\"thumbnail_url\":\"https://d3ba8mq6xd4ncz.cloudfront.net/d81fb14258db8826dbbcbb00b4b8ef2e9f5de0ec.jpg\",\"image_url\":\"https://d1zkpmdxaytijy.cloudfront.net/d81fb14258db8826dbbcbb00b4b8ef2e9f5de0ec.jpg\",\"image_aspect_ratio\":0.75}]"*/
    
    var jsonString = "[{\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437686085640257858,\"entry_id_str\": \"2437686085640257858\",\"date\": \"2018-04-30\",\"date_stamp\": 1525046401,\"title\": \"Imagine being there....\",\"username\": \"HilarysView\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/54ddd4274cd42d7b04b27afc56345abc0909a6f1.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/54ddd4274cd42d7b04b27afc56345abc0909a6f1.jpg\",\"image_aspect_ratio\" : 1.50470219}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437617096310391581,\"entry_id_str\": \"2437617096310391581\",\"date\": \"2018-04-30\",\"date_stamp\": 1525046401,\"title\": \"The Sorceress of Spring consults her Magic 8 Ball\",\"username\": \"justbe\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/1414992ca70c608077b9edb2a00ca117957870b0.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/1414992ca70c608077b9edb2a00ca117957870b0.jpg\",\"image_aspect_ratio\" : 1.5}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437337971200886582,\"entry_id_str\": \"2437337971200886582\",\"date\": \"2018-04-29\",\"date_stamp\": 1524960001,\"title\": \"For the love . . .\",\"username\": \"PaulaJ\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/90b7cdd04379f1812d35ed2a820f99d1ea583e9f.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/90b7cdd04379f1812d35ed2a820f99d1ea583e9f.jpg\",\"image_aspect_ratio\" : 1.5}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437434560477137667,\"entry_id_str\": \"2437434560477137667\",\"date\": \"2018-04-29\",\"date_stamp\": 1524960001,\"title\": \"8 years!\",\"username\": \"NannaK\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/c0ea2e48417014c90d3c27b2935350040a3beaba.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/c0ea2e48417014c90d3c27b2935350040a3beaba.jpg\",\"image_aspect_ratio\" : 1.32596685}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437714056858042691,\"entry_id_str\": \"2437714056858042691\",\"date\": \"2018-04-30\",\"date_stamp\": 1525046401,\"title\": \"Welcome Home!\",\"username\": \"dbifulco\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/a39e2d742089e1fa10b99415689d549a80f90d8f.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/a39e2d742089e1fa10b99415689d549a80f90d8f.jpg\",\"image_aspect_ratio\" : 1.32596685}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437276593656172459,\"entry_id_str\": \"2437276593656172459\",\"date\": \"2018-04-29\",\"date_stamp\": 1524960001,\"title\": \"Motes of Morning Light and a Golden Cow\",\"username\": \"HilarysView\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/54e2a3d055bffe9fda70844d7e9c5cde776edb1f.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/54e2a3d055bffe9fda70844d7e9c5cde776edb1f.jpg\",\"image_aspect_ratio\" : 1.26315789}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437772975403962050,\"entry_id_str\": \"2437772975403962050\",\"date\": \"2018-04-30\",\"date_stamp\": 1525046401,\"title\": \"Peli\",\"username\": \"Hillyblips\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/b3ee2cf9f506522a5f9d415a3744419867c44bd5.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/b3ee2cf9f506522a5f9d415a3744419867c44bd5.jpg\",\"image_aspect_ratio\" : 1.28170895}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437385861503912340,\"entry_id_str\": \"2437385861503912340\",\"date\": \"2018-04-29\",\"date_stamp\": 1524960001,\"title\": \"“AT REST”\",\"username\": \"SSN595\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/ea857ce22f9ec8bf9ca25ad4fd67b92940bd3b88.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/ea857ce22f9ec8bf9ca25ad4fd67b92940bd3b88.jpg\",\"image_aspect_ratio\" : 1.65803109}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437227133198665280,\"entry_id_str\": \"2437227133198665280\",\"date\": \"2018-04-29\",\"date_stamp\": 1524960001,\"title\": \"City Park\",\"username\": \"mambo\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/f0c5d65a132d57fc18fd16b5c2b25164a1be5e9e.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/f0c5d65a132d57fc18fd16b5c2b25164a1be5e9e.jpg\",\"image_aspect_ratio\" : 1.24352332}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437338289179461595,\"entry_id_str\": \"2437338289179461595\",\"date\": \"2018-04-29\",\"date_stamp\": 1524960001,\"title\": \"Whensday ... Not!\",\"username\": \"cblinks2\",\"location\": {    \"lat\": 57.421082,    \"lon\": -1.846737},\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/e9edd20ae94eb2f1a30ee030f8b9f7c8c91def8f.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/e9edd20ae94eb2f1a30ee030f8b9f7c8c91def8f.jpg\",\"image_aspect_ratio\" : 1.06785317}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2438138817832553339,\"entry_id_str\": \"2438138817832553339\",\"date\": \"2018-05-01\",\"date_stamp\": 1525132801,\"title\": \"Big Floating Clouds & Striped Yellow Fields\",\"username\": \"SarumStroller\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/80f1bbd727c92a49bf668994dea8dfe76981a202.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/80f1bbd727c92a49bf668994dea8dfe76981a202.jpg\",\"image_aspect_ratio\" : 0.66666667}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437768080592472063,\"entry_id_str\": \"2437768080592472063\",\"date\": \"2018-04-30\",\"date_stamp\": 1525046401,\"title\": \"'Regimented, Like Soldiers'\",\"username\": \"SarumStroller\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/37892ce09d7036ff0678b6a962a49c1a72b19d5d.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/37892ce09d7036ff0678b6a962a49c1a72b19d5d.jpg\",\"image_aspect_ratio\" : 0.66666667}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437359812791504778,\"entry_id_str\": \"2437359812791504778\",\"date\": \"2018-04-29\",\"date_stamp\": 1524960001,\"title\": \"fab day\",\"username\": \"Nicpic\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/4b183eb6ab0e6ee7669e53519dbe075e9cd32584.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/4b183eb6ab0e6ee7669e53519dbe075e9cd32584.jpg\",\"image_aspect_ratio\" : 2.01680672}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437328904524924115,\"entry_id_str\": \"2437328904524924115\",\"date\": \"2018-04-29\",\"date_stamp\": 1524960001,\"title\": \"HOVERFLY ON BUTTERCUP\",\"username\": \"admirer\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/082d84c40fe1b780b4fa061af4133b19dd2d17a1.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/082d84c40fe1b780b4fa061af4133b19dd2d17a1.jpg\",\"image_aspect_ratio\" : 1.4953271}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437660191978687377,\"entry_id_str\": \"2437660191978687377\",\"date\": \"2018-04-30\",\"date_stamp\": 1525046401,\"title\": \"Spice box\",\"username\": \"Miranda1008\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/219d0c746f0045603fbf730bb6c5537e434abb9a.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/219d0c746f0045603fbf730bb6c5537e434abb9a.jpg\",\"image_aspect_ratio\" : 1.5}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437963702473852661,\"entry_id_str\": \"2437963702473852661\",\"date\": \"2018-04-30\",\"date_stamp\": 1525046401,\"title\": \"Moonrise over the Opera House\",\"username\": \"jensphotos\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/63a7a9164fd617e098e6deafed2759fd43581e5d.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/63a7a9164fd617e098e6deafed2759fd43581e5d.jpg\",\"image_aspect_ratio\" : 1.5}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2438054676931808173,\"entry_id_str\": \"2438054676931808173\",\"date\": \"2018-05-01\",\"date_stamp\": 1525132801,\"title\": \"Traditions....\",\"username\": \"lovelupins17\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/9ef156157971a777fab483472a51fb7d1ddbb991.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/9ef156157971a777fab483472a51fb7d1ddbb991.jpg\",\"image_aspect_ratio\" : 1.53846154}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2438072498621776297,\"entry_id_str\": \"2438072498621776297\",\"date\": \"2018-05-01\",\"date_stamp\": 1525132801,\"title\": \"Tulips...\",\"username\": \"AngelsShare\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/a4815d539a4fdef9b45e7e25dd2ee7ffb01c0e65.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/a4815d539a4fdef9b45e7e25dd2ee7ffb01c0e65.jpg\",\"image_aspect_ratio\" : 1.5}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437323105308248137,\"entry_id_str\": \"2437323105308248137\",\"date\": \"2018-04-29\",\"date_stamp\": 1524960001,\"title\": \"Mountain Walk\",\"username\": \"BobsBlips\",\"location\": {    \"lat\": 51.595194,    \"lon\": -3.122023},\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/0dfcdbe2c95e5076e30716d320c77a111e2109fa.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/0dfcdbe2c95e5076e30716d320c77a111e2109fa.jpg\",\"image_aspect_ratio\" : 1.5}}, {\"entry\": {\"object\": \"Entry\",\"entry_id\": 2437198223023014868,\"entry_id_str\": \"2437198223023014868\",\"date\": \"2018-04-29\",\"date_stamp\": 1524960001,\"title\": \"Night glow at Hororata\",\"username\": \"mpp26\",\"location\": null,\"thumbnail_url\": \"https://d3ba8mq6xd4ncz.cloudfront.net/e1b1c76ae6390463d72f791c54e746f4f25e95bf.jpg\",\"image_url\": \"https://d1zkpmdxaytijy.cloudfront.net/e1b1c76ae6390463d72f791c54e746f4f25e95bf.jpg\",\"image_aspect_ratio\" : 1.52866242}}]"
    
    var entryResponses : [EntryResponse] = []
    
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
        self.browseTableView.register(UINib(nibName: "BrowseTableViewCell", bundle:nil), forCellReuseIdentifier: "BrowseTableViewCell")
        browseTableView.rowHeight = UITableViewAutomaticDimension
        browseTableView.estimatedRowHeight = 195
        
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        entryResponses = try! decoder.decode([EntryResponse].self, from: jsonData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // If a table cell was selected before the view disappeared, deleselect it now.
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
        let cell : BrowseTableViewCell = self.browseTableView!.dequeueReusableCell(withIdentifier: "BrowseTableViewCell")! as! BrowseTableViewCell
        cell.label.text = sections[indexPath.row]["title"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Set the cell delegate and reset the cell position to its previous state, if there was one.
        guard let browseTableCell = cell as? BrowseTableViewCell else { return }
        browseTableCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        browseTableCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Store the cell position so we can restore it later.
        guard let browseTableCell = cell as? BrowseTableViewCell else { return }
        storedOffsets[indexPath.row] = browseTableCell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entryStreamViewController = EntryStreamViewController.init(nibName: "EntryStreamView", entryResponses: entryResponses, bundle: nil)
        entryStreamViewController.title = sections[indexPath.row]["title"]
        self.navigationController?.pushViewController(entryStreamViewController, animated: true)
    }
    
    // Collection data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entryResponses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EntryCollectionViewCell", for: indexPath) as! EntryCollectionViewCell
        let entryResponse = entryResponses[indexPath.row]
        
        let url = URL(string: entryResponse.entry.thumbnail_url)!
        cell.primaryImageView.sd_setImage(with: url, placeholderImage:nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let entryViewController = EntryViewController(nibName: "EntryView", bundle: nil)
        self.presentJournalController(entryViewController)
        
    }
    
}

