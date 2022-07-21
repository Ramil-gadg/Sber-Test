//
//  ConditionTypeModel.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 20.07.2022. 
//


import UIKit

class ConditionTypeModel {
    
    private var type: IllConditionTypeModel
    
    var typeName: String? {
        type.name
    }
    
    var typeColor: UIColor? {
        Formatter.hexStringToUIColor(hex: type.color)
    }
    
    var id: Int {
        type.id
    }
    
    init(type: IllConditionTypeModel) {
        self.type = type
    }
    
}
