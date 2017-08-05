//
//  DetailView.swift
//  Lickability
//
//  Created by Daniel Lee on 8/4/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class DetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.cornerRadius = 4
        setUpDetailView(labelContainerHeight: 0.3)
    }
    
    var mainVC: MainVC?
    
    var swatch: Swatch? {
        didSet {
            if let albumID = swatch?.albumId, let ID = swatch?.id {
                albumIdLabel.text = "Album ID:  \(albumID)"
                idLabel.text = "Individual ID:  \(ID)"
            }
            titleLabel.text = swatch?.title
            
            if let url = swatch?.url,
            let _mainVC = self.mainVC {
                swatchImage.downloadImage(mainVC: _mainVC, imageURL: url)
            }
        }
    }
    
    let swatchImage: UIImageView = {
        let _swatchImage = UIImageView()
        _swatchImage.backgroundColor = defaultSwatchColor
        _swatchImage.contentMode = .scaleAspectFill
        _swatchImage.translatesAutoresizingMaskIntoConstraints = false
        return _swatchImage
    }()
    
    let labelsContainer: UIView = {
        let _labelsContainer = UIView()
        _labelsContainer.backgroundColor = globalBlackTintColor
        _labelsContainer.layer.cornerRadius = 4
        _labelsContainer.translatesAutoresizingMaskIntoConstraints = false
        return _labelsContainer
    }()
    
    let albumIdLabel = UILabel().smallDetailLbl
    let idLabel = UILabel().smallDetailLbl
    let titleLabel = UILabel().largeDetailLbl
    let urlLabel = UILabel().smallDetailLbl
    let thumbnailUrlLabel = UILabel().smallDetailLbl
    
    fileprivate func setUpDetailView(labelContainerHeight: CGFloat) {
        self.addSubview(swatchImage)
        self.addSubview(labelsContainer)
        
        swatchImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        swatchImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        swatchImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        swatchImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        labelsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        labelsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        labelsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        labelsContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: labelContainerHeight).isActive = true
        
        setUpLabelsContainer(titleSpaceMultiplier: 0.6)
    }
    
    fileprivate func setUpLabelsContainer(titleSpaceMultiplier: CGFloat) {
        labelsContainer.addSubview(titleLabel)
        labelsContainer.addSubview(albumIdLabel)
        labelsContainer.addSubview(idLabel)
        
        for label in labelsContainer.subviews {
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.heightAnchor.constraint(equalTo: labelsContainer.heightAnchor, multiplier: titleSpaceMultiplier).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor, constant: -8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor).isActive = true
        
        albumIdLabel.heightAnchor.constraint(equalTo: labelsContainer.heightAnchor, multiplier: (1 - titleSpaceMultiplier)/2).isActive = true
        albumIdLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        albumIdLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor, constant: 8).isActive = true
        albumIdLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor, constant: -8).isActive = true
        
        idLabel.heightAnchor.constraint(equalTo: labelsContainer.heightAnchor, multiplier: (1 - titleSpaceMultiplier)/2).isActive = true
        idLabel.topAnchor.constraint(equalTo: albumIdLabel.bottomAnchor).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor, constant: 8).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
