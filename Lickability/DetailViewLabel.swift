//
//  DetailViewLabel.swift
//  Lickability
//
//  Created by Daniel Lee on 8/5/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

extension UILabel {

    var smallDetailLbl: UILabel {
        self.font = UIFont(name: "futura", size: 10)
        self.textColor = globalBackgroundColor
        return self
    }
    
    var largeDetailLbl: UILabel {
        self.font = UIFont(name: "futura", size: 20)
        self.textColor = globalBackgroundColor
        return self
    }
    
}
