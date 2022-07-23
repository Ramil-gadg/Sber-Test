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
}
