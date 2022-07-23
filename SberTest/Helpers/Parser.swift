//
//  Parser.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 21.07.2022.
//

import Foundation


enum Parser {
    
    /// преобразование модели из data в удобную модель для работы с collection view
    static func parseDataToConvienceModel(dataModel: IllModel) -> [VisualGraphModel] {
        
        var collectionDataSource = [VisualGraphModel]()
        
        /// максимальное значение в столбце
        /// потребуется для вычисления высоты столбцов ячеек
        var maxAmount = 0
        
        /// модель для работы с ячейкой, которая содержит значения по всем регионам "Итого"
        var allVisualGraphModel = VisualGraphModel(type: .all)
        
        /// формируем ячейку "Итого"
        dataModel.conditionTypes.forEach { conditionType in
            dataModel.amountTypes
                .filter({ $0.conditionId == conditionType.id })
                .forEach({ amountType in
                let color = Formatter.hexStringToUIColor(hex: conditionType.color)
                if allVisualGraphModel.conditionWithAmountDict[color] != nil {
                    allVisualGraphModel.conditionWithAmountDict[color]! += amountType.value
                } else {
                    allVisualGraphModel.conditionWithAmountDict[color] = amountType.value
                }
                allVisualGraphModel.maxAmount += amountType.value
                maxAmount = allVisualGraphModel.maxAmount
            })
        }
        
        /// заполняем основную модель моделью "Итого"
        collectionDataSource.append(allVisualGraphModel)
        
        /// формируем ячейки по каждому региону
        dataModel.regionTypes.forEach { region in
            
            /// модель для работы с ячейкой для каждого региона
            var visualGraphModel = VisualGraphModel(type: .region(region))
            
            dataModel.amountTypes
                .filter { $0.regionId == region.id }
                .forEach { amountType in
                dataModel.conditionTypes.forEach { conditionType in
                    if amountType.conditionId == conditionType.id {
                        let color = Formatter.hexStringToUIColor(hex: conditionType.color)
                        
                        visualGraphModel.conditionWithAmountDict[color] = amountType.value
                        visualGraphModel.maxAmount = maxAmount
                    }
                }
            }
            
            /// заполняем основную модель моделями c регионами
            collectionDataSource.append(visualGraphModel)
        }
        
        return collectionDataSource
    }
}
