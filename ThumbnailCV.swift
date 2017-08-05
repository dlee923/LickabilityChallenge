//
//  ThumbnailCV.swift
//  Lickability
//
//  Created by Daniel Lee on 8/3/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class ThumbnailCV: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpThumbnailCV()
    }
    
    let numberPerRow: CGFloat = 5

    private let genericCell = "genericCell"
    private let thumbnailCell = "thumbnailCell"
    
    var mainVC: MainVC?
    
    var detailContainer: UIView?
    var detailView: DetailView?
    let detailViewHeightMultiplier: CGFloat = 0.6
    let detailViewWidthMultiplier: CGFloat = 0.8
    
    let highlightThumbnailScale: CGFloat = 1.5
    
    var swatches: [Swatch]? {
        didSet {
            print("thumbnail swatches changed")
            self.collectionView?.reloadData()
//            self.moveCellsOnSceen(isRemoving: false) {
//                self.collectionView?.reloadData()
//            }
        }
    }
    
    fileprivate func setUpThumbnailCV() {
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: genericCell)
        self.collectionView?.register(ThumbnailCVCell.self, forCellWithReuseIdentifier: thumbnailCell)
        self.collectionView?.backgroundColor = globalBackgroundColor
        self.collectionView?.clipsToBounds = false
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swatches?.count ?? 50
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thumbnailCell, for: indexPath) as? ThumbnailCVCell {
            cell.image.image = nil
            cell.mainVC = self.mainVC
            cell.swatch = swatches?[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: genericCell, for: indexPath)
            return cell
        }
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        // scale cell size to increase
        if let highlightedCell = collectionView.cellForItem(at: indexPath) as? ThumbnailCVCell {
            self.collectionView?.bringSubview(toFront: highlightedCell)
            UIView.animate(withDuration: 0.1, animations: {
                highlightedCell.transform = CGAffineTransform(scaleX: self.highlightThumbnailScale, y: self.highlightThumbnailScale)
            })
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        // revert cell back to original size
        if let highlightedCell = collectionView.cellForItem(at: indexPath) as? ThumbnailCVCell {
            UIView.animate(withDuration: 0.1, animations: {
                highlightedCell.transform = CGAffineTransform.identity
            })
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cellSelected = collectionView.cellForItem(at: indexPath) as? ThumbnailCVCell {            
            self.generateDetailView(cell: cellSelected, heightMultiplier: detailViewHeightMultiplier, widthMultiplier: detailViewWidthMultiplier)
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewWidth = self.collectionView?.frame.width else { return CGSize.zero }
        guard let inset = mainVC?.thumbnailCVInset else { return CGSize.zero }
        
        let modifiedWidth = collectionViewWidth - (inset * numberPerRow)
        
        let cellSize = CGSize(width: modifiedWidth / numberPerRow, height: modifiedWidth / numberPerRow)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // top bottom border spacing
        guard let inset = mainVC?.thumbnailCVInset else { return 0 }
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // left right border spacing
        guard let inset = mainVC?.thumbnailCVInset else { return 0 }
        return inset
    }
    
    func moveCellsOnSceen(isRemoving: Bool, completion: () -> ()) {
        if let thumbnails = self.collectionView?.visibleCells {
            
            if isRemoving {
                var delay: Double = 0
                for thumbnail in thumbnails {
//                    print("moving thumbnail off")
                    UIView.animate(withDuration: 0.1, delay: TimeInterval(0 + delay), options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        thumbnail.transform = CGAffineTransform(translationX: (self.mainVC?.view.frame.width)!, y: 0)
                    })
                    delay += 0.01
                }
            
            } else {
                for thumbnail in thumbnails {
                    thumbnail.transform = CGAffineTransform(translationX: (self.mainVC?.view.frame.width)!, y: 0)
//                    print("moving thumbnail offAtOnce")
                }
                var delay: Double = 0
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.1, execute: { 
                    for thumbnail in thumbnails {
//                        print("moving thumbnail on")
                        UIView.animate(withDuration: 0.1, delay: TimeInterval(0 + delay), options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            thumbnail.transform = CGAffineTransform.identity
                        })
                        delay += 0.01
                    }
                })
                
            }
        }
        
        completion()
    }

}
