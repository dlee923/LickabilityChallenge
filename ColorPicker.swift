//
//  ColorPicker.swift
//  Lickability
//
//  Created by Daniel Lee on 8/4/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class ColorPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPickerView()
    }
    
    var mainVC: MainVC?
    
    var mainVCSwatches: [[Swatch]]? {
        didSet {
            var tempAlbumSwatches = [Swatch]()
            for swatchArray in mainVCSwatches! {
                let swatch = swatchArray.first
                tempAlbumSwatches.append(swatch!)
            }
            albumSwatches = tempAlbumSwatches
        }
    }
    
    var albumSwatches: [Swatch]? {
        didSet {
            self.reloadAllComponents()            
        }
    }
    
    let pickerViewSize: CGFloat = 50
    
    fileprivate func setUpPickerView() {
        self.dataSource = self
        self.delegate = self        
        self.transform = CGAffineTransform(rotationAngle: CGFloat(-90 * (Double.pi / 180)))
    }
    
    // MARK: PickerView DataSource Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return albumSwatches?.count ?? 100
    }
    
    // MARK: PickerView Delegate Functions
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerViewSize
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerViewSize
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let colorView = ColorPickerView()
        colorView.mainVC = self.mainVC
        colorView.swatch = albumSwatches?[row]
        colorView.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return colorView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // sent appropriate swatch array to thumbnail collectionView
        mainVC?.thumbnailCVClass.swatches = mainVCSwatches?[row]
        if let albumID = mainVCSwatches?[row].first?.albumId {
            mainVC?.pickerViewAlbumLabel.text = "Album No. \(albumID)"
        }
        
        // animate thumbnail collectionView back to original start
        UIView.animate(withDuration: 0.2) {
            self.mainVC?.thumbnailCVClass.collectionView?.contentOffset = CGPoint.zero
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

