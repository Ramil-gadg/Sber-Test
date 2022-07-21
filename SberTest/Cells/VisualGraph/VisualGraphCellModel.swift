//
//  VisualGraphCellModel.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 20.07.2022.
//  
//

import UIKit

class VisualGraphCellModel {
    
    private var model: VisualGraphModel
    
    /// наибольшее количество значений
    /// в ячейке данной collectionView
    var maxAmount: Int {
        model.maxAmount
    }
    
    /// общее количество значений
    var commonAmount: String? {
        String(model.conditionWithAmountDict.values.reduce(0, +))
    }
    
    /// сортируем значения для каждого состояния по возрастанию
    var sortedAmounts: [Int] {
        model.conditionWithAmountDict.values.sorted()
    }
    
    /// упорядочиваем цвета согласно значениям по возрастанию
    var sortedColors: [UIColor] {
        model.conditionWithAmountDict.sorted(by: { $0.1 > $1.1 }).map { $0.key }
    }
    
    var name: String? {
        model.name
    }
    
    init(model: VisualGraphModel) {
        self.model = model
    }
    
    func cellForCollectionView(
        collectionView: UICollectionView,
        atIndexPath indexPath: IndexPath
    ) -> UICollectionViewCell {
    
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: VisualGraphCellModel.reuseIdentifier,
            for: indexPath
        ) as? VisualGraphCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        cell.configure(with: self)
        return cell
    }
    
    static var reuseIdentifier: String {
        String(describing: VisualGraphCollectionViewCell.self)
    }
    
    /// высоты верхненего и нижнего лейблов ячейки
    static var regionLblHeight: CGFloat = 50
    static var amountLblHeight: CGFloat = 30
    
}
