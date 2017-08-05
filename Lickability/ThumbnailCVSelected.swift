//
//  ThumbnailCVSelected.swift
//  Lickability
//
//  Created by Daniel Lee on 8/4/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

extension ThumbnailCV {
    
    // animate detail view properties and placement
    func generateDetailView(cell: ThumbnailCVCell, heightMultiplier: CGFloat, widthMultiplier: CGFloat) {
        instantiateDetailView(cell: cell, heightMultiplier: heightMultiplier, widthMultiplier: widthMultiplier)
        
        guard let _detailContainer = detailContainer else { return }
        guard let _detailView = detailView else { return }
        
        self.mainVC?.view.addSubview(_detailContainer)
        _detailContainer.addSubview(_detailView)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            _detailContainer.backgroundColor = UIColor.white.withAlphaComponent(0.7)
            _detailView.frame = CGRect(x: _detailContainer.frame.width * ((1-widthMultiplier)/2), y: _detailContainer.frame.height * ((1-heightMultiplier)/3), width: _detailContainer.frame.width * widthMultiplier, height: _detailContainer.frame.height * heightMultiplier)
        }, completion: nil)
    }
    
    // create detail view
    func instantiateDetailView(cell: ThumbnailCVCell, heightMultiplier: CGFloat, widthMultiplier: CGFloat) {
        guard let mainVCFrame = self.mainVC?.view.frame else { return }
        
        detailContainer = UIView(frame: mainVCFrame)
        detailContainer?.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        let dismissTouch = UITapGestureRecognizer(target: self, action: #selector(dismissDetail))
        detailContainer?.addGestureRecognizer(dismissTouch)
        
        let fauxFrame = cell.convert(cell.bounds, to: nil)
        detailView = DetailView(frame: fauxFrame)
        detailView?.mainVC = self.mainVC
        detailView?.swatch = cell.swatch
    }
    
    // dismiss detail view from screen
    func dismissDetail() {
        UIView.animate(withDuration: 0.125, animations: {
            self.detailView?.frame.origin.y = self.view.frame.height
        }) { (_) in
            self.detailContainer?.removeFromSuperview()
        }
    }
    
}
