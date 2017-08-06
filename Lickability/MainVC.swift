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
            
            let thumbnailSwatches = swatches?[pickerView.selectedRow(inComponent: 0)]
            thumbnailCVClass.swatches = thumbnailSwatches
            
            if let albumID = thumbnailSwatches?.first?.albumId {
                self.pickerViewAlbumLabel.text = "Album No. \(albumID)"
            }
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
    
    let pickerViewHeightMultiple: CGFloat = 0.15
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
    
    let pickerViewAlbumLabel: UILabel = {
        let _pickerViewAlbumLabel = UILabel()
        _pickerViewAlbumLabel.font = UIFont(name: "futura", size: 12)
        _pickerViewAlbumLabel.text = "Album No. "
        _pickerViewAlbumLabel.textColor = globalBlackTintColor
        _pickerViewAlbumLabel.textAlignment = .right
        return _pickerViewAlbumLabel
    }()
    
    let pickerViewTitle: UILabel = {
        let _pickerViewTitle = UILabel()
        _pickerViewTitle.font = UIFont(name: "futura", size: 12)
        _pickerViewTitle.text = "Select Your Album Below"
        _pickerViewTitle.textColor = globalBlackTintColor
        _pickerViewTitle.textAlignment = .left
        return _pickerViewTitle
    }()
    
    let backgroundCoverView = UIView()
    
    let imageCache: NSCache<AnyObject, AnyObject> = {
        let _imageCache = NSCache<AnyObject, AnyObject>()
        _imageCache.countLimit = 200
        return _imageCache
    }()
}

