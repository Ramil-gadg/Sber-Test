//
//  MyChartFactory.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 21.07.2022.
//

import UIKit

enum MyChartFactory: ChartFactory {
    
    static func chart(data: Data) -> UIView? {
        
        do {
            let model = try JSONDecoder().decode(IllModel.self, from: data)
            let collectionDataSource = Parser.parseDataToConvienceModel(dataModel: model)
            
            return MyChartView(
                with: collectionDataSource,
                conditionTypes:
                    model.conditionTypes
            )
        } catch {
            return nil
        }
    }
    
}


