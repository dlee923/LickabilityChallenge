//
//  MainVCViewSetUp.swift
//  Lickability
//
//  Created by Daniel Lee on 8/5/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

extension MainVC {
    
    func setUpPickerView() {
        pickerViewContainerHeight = self.view.frame.height * pickerViewHeightMultiple
        
        self.view.addSubview(backgroundCoverView)
        backgroundCoverView.backgroundColor = globalBackgroundColor
        backgroundCoverView.translatesAutoresizingMaskIntoConstraints = false
        backgroundCoverView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backgroundCoverView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backgroundCoverView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backgroundCoverView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: pickerViewHeightMultiple * 0.8).isActive = true
        
        self.view.addSubview(pickerViewContainer)
        pickerViewContainer.translatesAutoresizingMaskIntoConstraints = false
        pickerViewContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pickerViewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -thumbnailCVInset).isActive = true
        pickerViewContainer.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: pickerViewHeightMultiple).isActive = true
        pickerViewContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95).isActive = true
        
        pickerViewContainer.addSubview(pickerViewBackground)
        pickerViewBackground.translatesAutoresizingMaskIntoConstraints = false
        pickerViewBackground.centerXAnchor.constraint(equalTo: pickerViewContainer.centerXAnchor).isActive = true
        pickerViewBackground.centerYAnchor.constraint(equalTo: pickerViewContainer.centerYAnchor).isActive = true
        pickerViewBackground.heightAnchor.constraint(equalTo: pickerViewContainer.heightAnchor).isActive = true
        pickerViewBackground.widthAnchor.constraint(equalTo: pickerViewContainer.widthAnchor).isActive = true
        
        pickerViewContainer.addSubview(pickerViewTitle)
        pickerViewTitle.translatesAutoresizingMaskIntoConstraints = false
        pickerViewTitle.topAnchor.constraint(equalTo: pickerViewContainer.topAnchor).isActive = true
        pickerViewTitle.leadingAnchor.constraint(equalTo: pickerViewContainer.leadingAnchor, constant: 8).isActive = true
        pickerViewTitle.widthAnchor.constraint(equalTo: pickerViewContainer.widthAnchor, multiplier: 0.6)
        pickerViewTitle.heightAnchor.constraint(equalToConstant: pickerViewContainerHeight! * 0.3).isActive = true
        
        pickerViewContainer.addSubview(pickerViewAlbumLabel)
        pickerViewAlbumLabel.translatesAutoresizingMaskIntoConstraints = false
        pickerViewAlbumLabel.topAnchor.constraint(equalTo: pickerViewContainer.topAnchor).isActive = true
        pickerViewAlbumLabel.leadingAnchor.constraint(equalTo: pickerViewTitle.trailingAnchor, constant: -8).isActive = true
        pickerViewAlbumLabel.trailingAnchor.constraint(equalTo: pickerViewContainer.trailingAnchor).isActive = true
        pickerViewAlbumLabel.heightAnchor.constraint(equalToConstant: pickerViewContainerHeight! * 0.3).isActive = true
        
        pickerViewContainer.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.centerXAnchor.constraint(equalTo: pickerViewContainer.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: pickerViewContainer.centerYAnchor, constant: pickerViewContainerHeight! * 0.15).isActive = true
        pickerView.heightAnchor.constraint(equalTo: pickerViewContainer.widthAnchor, multiplier: 1.25).isActive = true
        pickerView.widthAnchor.constraint(equalTo: pickerViewContainer.heightAnchor, multiplier: 0.7).isActive = true
    }
    
    func setUpThumbNailImages() {
        guard let thumbnailCV = thumbnailCVClass.collectionView else { return }
        self.view.insertSubview(thumbnailCV, belowSubview: backgroundCoverView)
        thumbnailCV.translatesAutoresizingMaskIntoConstraints = false
        thumbnailCV.topAnchor.constraint(equalTo: self.view.topAnchor, constant: thumbnailCVInset + 20).isActive = true
        thumbnailCV.bottomAnchor.constraint(equalTo: pickerViewContainer.topAnchor).isActive = true
        thumbnailCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: thumbnailCVInset).isActive = true
        thumbnailCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -thumbnailCVInset).isActive = true
    }

}
