//
//  ThumbnailRefresher.swift
//  Lickability
//
//  Created by Daniel Lee on 8/5/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class ThumbnailRefresher: UIRefreshControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpRefresher()
    }
    
    var mainVC: MainVC?
    
    func setUpRefresher() {
        self.layer.zPosition = -1
        self.attributedTitle = NSAttributedString(string: "PULL TO REFRESH", attributes: [NSFontAttributeName: UIFont(name: "futura", size: 10), NSForegroundColorAttributeName: UIColor.black])
        self.addTarget(self, action: #selector(self.downloadSwatches(sender:)), for: .valueChanged)
    }
    
    func downloadSwatches(sender: UIRefreshControl) {
        sender.beginRefreshing()
        
        mainVC?.webService.downloadObjectsAsJson(completion: { (downloadedSwatches) in
            self.mainVC?.swatches = downloadedSwatches
            sender.endRefreshing()
        })
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
