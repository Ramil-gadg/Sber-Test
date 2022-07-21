//
//  ChartFactory.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 21.07.2022.
//

import UIKit

protocol ChartFactory {
    static func chart(data: Data) -> UIView?
}
