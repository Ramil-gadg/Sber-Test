//
//  String + Extension.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 20.07.2022.
//

import UIKit

extension String {
    
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
    
}
