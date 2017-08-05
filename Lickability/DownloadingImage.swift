//
//  DownloadingImage.swift
//  Lickability
//
//  Created by Daniel Lee on 8/4/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

extension UIImageView {

    func downloadImage(mainVC: MainVC, imageURL: String) {
        // check if image exists in queue on mainVC
        if let cachedImage = mainVC.imageCache.object(forKey: imageURL as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        let url = URL(string: imageURL)
        DispatchQueue.global().async {
            let imageData = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                if let image = UIImage(data: imageData!) {
                    // add image to queue
                    mainVC.imageCache.setObject(image, forKey: imageURL as AnyObject)
                    self.image = image
                }
            }
        }
    }
    
}
