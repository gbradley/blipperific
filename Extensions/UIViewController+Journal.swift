//
//  UIViewController+Journal
//  Blipperific
//
//  Created by Graham on 25/05/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentJournalController(_ controller : UIViewController) {
        
        if ((self.navigationController?.presentingViewController) != nil) {
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            let journalNavigationController = UINavigationController.init(rootViewController: controller)
            
            journalNavigationController.modalTransitionStyle = .coverVertical
            self.present(journalNavigationController, animated: true)
        }
    }
    
}
