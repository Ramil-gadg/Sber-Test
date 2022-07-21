//
//  MyChartViewController.swift
//  SberTest
//
//  Created by Рамил Гаджиев on 21.07.2022.
//

import UIKit
import SnapKit

class MyChartViewController: UIViewController {
    
    var dataProvider: GraphDataProviderProtocol = GraphDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Visual Graph"
        
        dataProvider.fetchData { [weak self] data in
            
            guard let self = self,
                  let data = data,
                  let myView = MyChartFactory.chart(data: data)
            else { return }
            
            self.view.addSubview(myView)
            
            myView.snp.makeConstraints { make in
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
                make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            }
        }
    }
    
}

