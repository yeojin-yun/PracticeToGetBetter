//
//  ViewPager.swift
//  TabBarPaging
//
//  Created by 순진이 on 2022/08/05.
//

import UIKit

class ViewPager: UIView {
    public let sizeConfiguaration: TabView.SizeConfiguration
    let pageView = PageView()
    lazy var tabView = TabView(sizeConfiguration: sizeConfiguaration, tabs: <#T##[TabItemProtocol]#>)
    
    init(tabSizeConfiguration: TabView.SizeConfiguration) {
        self.sizeConfiguaration = tabSizeConfiguration
        super.init(frame: .zero)
        
        self.setupUI()
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        
    }
    
}

extension ViewPager: TabViewDelegate {
    func didMoveToTab(at index: Int) {
        
    }
}


extension PageView: PageViewDelegate {
    func didMoveToPage(index: Int) {
        <#code#>
    }
}
