//
//  Swatch.swift
//  Lickability
//
//  Created by Daniel Lee on 8/3/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import Foundation
import UIKit

class Swatch: NSObject {

    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    init(albumId: Int, id: Int, title: String, url: String, thumbnailUrl: String) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
}
