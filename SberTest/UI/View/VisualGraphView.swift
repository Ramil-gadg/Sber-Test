//
//  VisualGraphView.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 20.07.2022.
//

import UIKit

class VisualGraphView: UIView {
    
    //MARK: -  Variables
    var color: UIColor?
    var amount: Int
    var multiplayer: CGFloat
    
    //MARK: -  UI
    private let mainView = UIView()
    
    private let countLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 13, weight: .regular)
        lbl.textAlignment = .center
        return lbl
    }()
    
    init(with amount: Int, color: UIColor?, multiplayer: CGFloat) {
        self.amount = amount
        self.color = color
        self.multiplayer = multiplayer
        super.init(frame: .zero)
        
        initUI()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        checkNeedToShowAmount()
    }
    
    private func initUI() {
        clipsToBounds = false
        self.addSubview(mainView)
        mainView.backgroundColor = color
        mainView.addSubview(countLabel)
        countLabel.text = String(amount)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(moveToCenter))
        gesture.cancelsTouchesInView = false
        addGestureRecognizer(gesture)
    }
    
    private func initConstraints() {
        mainView.snp.makeConstraints { make in
            make.height.equalTo(multiplayer * CGFloat(amount))
            make.leading.centerX.bottom.top.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

//MARK: - Gesture Processing
extension VisualGraphView {
    
    @objc func moveToCenter(_ gesture: UILongPressGestureRecognizer) {
        self.moveToScreenCenter(with: gesture)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = .zero
        layer.shadowRadius = 7
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        stopHighlighting()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        stopHighlighting()
    }
    
    private func stopHighlighting() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowRadius = 0.0
    }
    
}

//MARK: - Private extension
private extension VisualGraphView {
    
    private func checkNeedToShowAmount() {
        
        /// если лейбл по высоте не вмещается во вьюшку, то скрываем его
        countLabel.isHidden = countLabel.text?.height(
            constraintedWidth: self.bounds.width,
            font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ) ?? 0 > multiplayer * CGFloat(amount)
        ? true
        : false
    }
    
}
