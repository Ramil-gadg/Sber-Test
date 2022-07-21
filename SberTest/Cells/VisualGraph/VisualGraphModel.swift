//
//  VisualGraphModel.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 21.07.2022.
//

import UIKit

struct VisualGraphModel {
    
    var conditionWithAmountDict: [UIColor: Int] = [:]
    var type: VisualGraphModelType
    var maxAmount: Int = 0
    
    var name: String? {
        switch type {
            
        case .region(let region):
            return region.name
        case .all:
            return "Итого"
        }
    }
}
