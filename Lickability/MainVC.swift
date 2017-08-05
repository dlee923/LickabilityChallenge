//
//  MainVC.swift
//  Lickability
//
//  Created by Daniel Lee on 8/3/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webService.downloadObjectsAsJson { (downloadedSwatchInfo) in
            self.swatches = downloadedSwatchInfo
        }
        
        setUpPickerView()
        setUpThumbNailImages()
        
        self.view.backgroundColor = globalBackgroundColor
    }
    
    let thumbnailCVInset: CGFloat = 10
    
    var swatches: [[Swatch]]? {
        didSet {
            // load color picker - and first set of thumbnails
            pickerView.mainVCSwatches = self.swatches
            thumbnailCVClass.swatches = swatches?.first
        }
    }

    let webService = WebService()
    
    lazy var thumbnailCVClass: ThumbnailCV = {
        let _thumbnailCVClass = ThumbnailCV(collectionViewLayout: UICollectionViewFlowLayout())
        _thumbnailCVClass.mainVC = self
        return _thumbnailCVClass
    }()
    
    lazy var pickerView: ColorPicker = {
        let _pickerView = ColorPicker()
        _pickerView.mainVC = self
        return _pickerView
    }()
    
    let pickerViewHeightMultiple: CGFloat = 0.125
    let pickerViewContainer: UIView = {
        let _pickerViewContainer = UIView()
        _pickerViewContainer.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        _pickerViewContainer.layer.shadowColor = UIColor.black.cgColor
        _pickerViewContainer.layer.shadowRadius = 10
        _pickerViewContainer.layer.shadowOpacity = 0.5
        _pickerViewContainer.layer.cornerRadius = 2
        _pickerViewContainer.clipsToBounds = true
        return _pickerViewContainer
    }()
    
    let pickerViewBackground = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.extraLight))
    
    var pickerViewContainerHeight: CGFloat?
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    fileprivate func setUpPickerView() {
        pickerViewContainerHeight = self.view.frame.height * pickerViewHeightMultiple
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
        
        pickerViewContainer.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.centerXAnchor.constraint(equalTo: pickerViewContainer.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: pickerViewContainer.centerYAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalTo: pickerViewContainer.widthAnchor, multiplier: 1.25).isActive = true
        pickerView.widthAnchor.constraint(equalTo: pickerViewContainer.heightAnchor, multiplier: 1).isActive = true
    }
    
    fileprivate func setUpThumbNailImages() {
        guard let thumbnailCV = thumbnailCVClass.collectionView else { return }
        self.view.insertSubview(thumbnailCV, belowSubview: pickerViewContainer)
        thumbnailCV.translatesAutoresizingMaskIntoConstraints = false
        thumbnailCV.topAnchor.constraint(equalTo: self.view.topAnchor, constant: thumbnailCVInset + 20).isActive = true
        thumbnailCV.bottomAnchor.constraint(equalTo: pickerViewContainer.topAnchor).isActive = true
        thumbnailCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: thumbnailCVInset).isActive = true
        thumbnailCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -thumbnailCVInset).isActive = true
    }
}

