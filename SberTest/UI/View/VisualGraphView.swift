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
        self.addSubview(mainView)
        mainView.backgroundColor = color
        mainView.addSubview(countLabel)
        countLabel.text = String(amount)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(moveToCenter))
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
    
    @objc func moveToCenter(_ gesture: UILongPressGestureRecognizer) {
        let point = self.convert(CGPoint(x: self.frame.midX, y: self.frame.midY), to: self.window)
        let oopoint = CGPoint(x: self.window!.center.x - point.x, y: self.window!.center.y - point.y)
        let originalTransform = self.transform
        let translatedTransform = originalTransform.translatedBy(x: oopoint.x, y: oopoint.y + self.bounds.height/2)
        let translatedAndScaledTransform = translatedTransform.scaledBy(x: 1.25, y: 1.25)
        self.bringViewInCollectViewCellToFront()
        switch gesture.state {
        case .began:
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }

                self.transform = translatedAndScaledTransform
            }
        case .ended:
            UIView.animate(withDuration: 0.5) {
                self.transform = .identity
            }
        default:
            break
        }
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
