//
//  ConditionalTypeView.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 20.07.2022.
//

import UIKit

class ConditionalTypeView: UIView {
    
    //MARK: -  Variables
    private var color: UIColor?
    private var typeName: String?
    
    //MARK: -  UI
    private lazy var circleView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private var typeLabel: UILabel = {
        var label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    init(typeModel: ConditionTypeModel) {
        super.init(frame: .zero)
        typeName = typeModel.typeName
        color = typeModel.typeColor
        
        initUI()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleView.layer.cornerRadius = circleView.frame.height/2
    }
    
    private func initUI() {
        addSubview(circleView)
        addSubview(typeLabel)
        typeLabel.text = typeName
        circleView.backgroundColor = color
    }
    
    private func initConstraints() {
        
        circleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(12)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(circleView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
}
