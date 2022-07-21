//
//  VisualGraphCollectionViewCell.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 20.07.2022.
//
import UIKit

class VisualGraphCollectionViewCell: UICollectionViewCell {
    
    //MARK: -  Variables
    private var model: VisualGraphCellModel?
    private var stackSpacing: CGFloat = 2
    
    //MARK: -  UI
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        return stack
    }()
    
    private var comonAmountLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .semibold)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private var regionNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        lbl.textColor = .darkGray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        contentView.addSubview(stackView)
        contentView.addSubview(regionNameLbl)
        contentView.addSubview(comonAmountLbl)
        
        stackView.spacing = stackSpacing
    }
    
    private func initConstraints() {
        
        regionNameLbl.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(VisualGraphCellModel.regionLblHeight)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(regionNameLbl.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        comonAmountLbl.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(VisualGraphCellModel.amountLblHeight)
        }
    }
    
    func configure(with model: VisualGraphCellModel) {
        self.model = model
        self.comonAmountLbl.text = model.commonAmount
        self.regionNameLbl.text = model.name
        configureStack()
    }
    
    /// собираем стек столбца из цветных вьюшек
    private func configureStack() {
        
        guard let model = model else {
            return
        }
        
        /// очищаем стэк
        stackView.arrangedSubviews.forEach { (view) in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        /// вычисляем чистую высоту для всех цветных вьюшек
        let height = self.bounds.height - VisualGraphCellModel.regionLblHeight - VisualGraphCellModel.amountLblHeight - CGFloat(model.sortedAmounts.count) * self.stackSpacing
        
        /// получаем множитель для каждой вьюшки
        let multiplayer = height / CGFloat(model.maxAmount)
        
        /// создаем цветные вьюшки и кладем в стэк
        for (amount, color) in zip(model.sortedAmounts, model.sortedColors) {
            
            let graghView = VisualGraphView(with: amount, color: color, multiplayer: multiplayer)
            self.stackView.addArrangedSubview(graghView)
        }
        
    }
}
