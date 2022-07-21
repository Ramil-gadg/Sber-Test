//
//  ConditionTypeModel.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 20.07.2022.
//

import Foundation

struct IllModel: Decodable {
    let conditionTypes: [IllConditionTypeModel]
    let regionTypes: [IllRegionTypeModel]
    let amountTypes: [IllAmountTypeModel]
    
    enum CodingKeys: String, CodingKey {
        case conditionTypes = "series"
        case regionTypes = "xAxisValues"
        case amountTypes = "yAxisValues"
    }
}

struct IllConditionTypeModel: Decodable {
    let name: String
    let id: Int
    let ord: Int
    let color: String
    
}

struct IllRegionTypeModel: Decodable {
    let name: String
    let id: Int
    let ord: Int
    
}

struct IllAmountTypeModel: Decodable {
    let conditionId: Int
    let regionId: Int
    let value: Int
    
    enum CodingKeys: String, CodingKey {
        case conditionId = "seriesId"
        case regionId = "xAxisValueId"
        case value
    }
    
}
