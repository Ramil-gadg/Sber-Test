//
//  UIView + Extension.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 23.07.2022.
//

import Foundation
import UIKit

extension UIView {
    
    /// рекурсивно выводим view на первый план, пока не дойдем до CollectionView
    func bringViewInCollectViewCellToFront() {
        
        guard let superView = self.superview else {
            return
        }
        superView.bringSubviewToFront(self)
        if (superView as? UICollectionView) == nil {
            superView.bringViewInCollectViewCellToFront()
        }
    }
    
    func moveToScreenCenter(with gesture: UIGestureRecognizer) {
        let pointInWindowBounds = self.convert(CGPoint(x: self.bounds.midX, y: self.bounds.midY), to: self.window)
        let different = CGPoint(x: self.window!.center.x - pointInWindowBounds.x, y: self.window!.center.y - pointInWindowBounds.y)
        let originalTransform = self.transform
        let translatedTransform = originalTransform.translatedBy(x: different.x, y: different.y)
        let translatedAndScaledTransform = translatedTransform.scaledBy(x: 1.25, y: 1.25)
        switch gesture.state {
        case .began:
            self.bringViewInCollectViewCellToFront()
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                self.transform = translatedAndScaledTransform
            }
        case .ended, .cancelled, .failed:
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                self.transform = .identity
            }
        default:
            break
        }
    }
}
