//
//  GraphDataProviderProtocol.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 21.07.2022.
//

import Foundation

protocol GraphDataProviderProtocol {
    func fetchData(completion: ((Data?) -> Void)?)
}
