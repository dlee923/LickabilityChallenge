//
//  ColorPickerView.swift
//  Lickability
//
//  Created by Daniel Lee on 8/4/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class ColorPickerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    var mainVC: MainVC?
    
    var swatch: Swatch? {
        didSet {
            if let url = swatch?.thumbnailUrl,
            let _mainVC = self.mainVC {
                image.downloadImage(mainVC: _mainVC, imageURL: url)
            }
        }
    }
    
    let image: UIImageView = {
        let _image = UIImageView()
        _image.contentMode = .scaleAspectFill
        _image.translatesAutoresizingMaskIntoConstraints = false
        return _image
    }()
    
    fileprivate func setUpView() {
//        self.layer.cornerRadius = 4
//        self.layer.borderWidth = 1.5
//        self.layer.borderColor = UIColor(white: 0.2, alpha: 1).cgColor
        
        self.clipsToBounds = true        
        self.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
        self.addSubview(image)
        image.backgroundColor = defaultSwatchColor
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true        
    }
    
    let buttonAngle: CGFloat = 0.75
    
    override func draw(_ rect: CGRect) {
        let parallelogram = UIBezierPath()
        parallelogram.move(to: rect.origin)
        parallelogram.addLine(to: CGPoint(x: rect.width * buttonAngle, y: rect.origin.y))
        parallelogram.addLine(to: CGPoint(x: rect.width, y: rect.height))
        parallelogram.addLine(to: CGPoint(x: rect.width * (1 - buttonAngle), y: rect.height))
        parallelogram.close()
        
        let outlineColor = UIColor.black
        parallelogram.lineWidth = 3
        outlineColor.setStroke()
        parallelogram.stroke()
        
        let mask = CAShapeLayer()
        mask.path = parallelogram.cgPath
        self.layer.mask = mask
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
