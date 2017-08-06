//
//  ThumbnailCVCell.swift
//  Lickability
//
//  Created by Daniel Lee on 8/4/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class ThumbnailCVCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpImage()
        setUpCellProperties()
    }
    
    var mainVC: MainVC?
    
    let image: UIImageView = {
        let _image = UIImageView()
        _image.contentMode = .scaleAspectFill
        _image.translatesAutoresizingMaskIntoConstraints = false
        return _image
    }()
    
    var swatch: Swatch? {
        didSet {
            if let _mainVC = mainVC,
            let url = self.swatch?.thumbnailUrl {
                image.downloadImage(mainVC: _mainVC, imageURL: url)
            }
        }
    }
    
    fileprivate func setUpImage() {
        self.addSubview(image)
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    fileprivate func setUpCellProperties() {
        self.backgroundColor = defaultSwatchColor
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderWidth = 1.5
        self.layer.borderColor = globalBackgroundColor.cgColor
    }
    
    override func prepareForReuse() {
        image.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpImage()
    }
}
