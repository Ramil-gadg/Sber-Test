//
//  MyChartView.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 21.07.2022.
//

import UIKit

class MyChartView: UIView {
    
    //MARK: -  Variables
    private var models = [VisualGraphModel]()
    private var conditionTypes: [IllConditionTypeModel]?
    
    //MARK: -  UI
    private let mainView = UIView()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let horizontalScrolView = UIScrollView()
    
    private let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let graphCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: flowLayout
        )
        collectionView.register(
            VisualGraphCollectionViewCell.self,
            forCellWithReuseIdentifier: VisualGraphCellModel.reuseIdentifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    init(with models: [VisualGraphModel], conditionTypes: [IllConditionTypeModel]) {
        self.models = models
        self.conditionTypes = conditionTypes
        super.init(frame: .zero)
        
        initUI()
        initConstraints()
        fillHorizontalScroll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        graphCollectionView.collectionViewLayout.invalidateLayout()
        graphCollectionView.reloadData()
    }
    
    private func initUI() {
        backgroundColor = .white
        
        addSubview(mainView)
        mainView.addSubview(horizontalScrolView)
        horizontalScrolView.addSubview(horizontalStackView)
        
        mainView.addSubview(graphCollectionView)
        mainView.addSubview(separatorView)
        
        graphCollectionView.delegate = self
        graphCollectionView.dataSource = self
        
        horizontalScrolView.showsHorizontalScrollIndicator = false
    }
    
    private func initConstraints() {
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        horizontalScrolView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        graphCollectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(horizontalScrolView.snp.bottom)
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-VisualGraphCellModel.regionLblHeight)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
        }
    }
    
    /// заполняем верхний скролл с типами состояний (выявлено, госпитализировано...)
    private func fillHorizontalScroll() {
        
        conditionTypes?.forEach {
            let conditionTypeModel = ConditionTypeModel(type: $0)
            let view = ConditionalTypeView(typeModel: conditionTypeModel)
            horizontalStackView.addArrangedSubview(view)
        }
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MyChartView: UICollectionViewDelegate,
                       UICollectionViewDataSource,
                       UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let model = models[indexPath.row]
        
        let visualGraphModel = VisualGraphModel(conditionWithAmountDict: model.conditionWithAmountDict, type: model.type, maxAmount: model.maxAmount)
        
        let cellModel = VisualGraphCellModel(model: visualGraphModel)
        return cellModel.cellForCollectionView(collectionView: collectionView, atIndexPath: indexPath)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/5, height: collectionView.bounds.height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        
        UIScreen.main.bounds.width/12
    }
}
