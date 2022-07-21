//
//  GraphDataProvider.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 21.07.2022.
//

import UIKit

class GraphDataProvider: GraphDataProviderProtocol {
    
    func fetchData(completion: ((Data?) -> Void)?) {
        
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "IILData", ofType: "json") {
                do {
                    let data = try Data(
                        contentsOf: URL(fileURLWithPath: path),
                        options: .mappedIfSafe
                    )
                    DispatchQueue.main.async {
                        completion?(data)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion?(nil)
                    }
                }
            }
        }
    }
    
}
