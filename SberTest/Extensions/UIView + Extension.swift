//
//  UIView + Extension.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 23.07.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func bringViewInCollectViewCellToFront() {
        guard let superView = self.superview else {
                  return
              }
        superView.bringSubviewToFront(self)
        if let collView = superView as? UICollectionView {
            collView.bringSubviewToFront(self)
            return
        } else {
            superView.bringViewInCollectViewCellToFront()
        }
    }
}
