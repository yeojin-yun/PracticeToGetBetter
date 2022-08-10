//
//  TabView.swift
//  TabBarPaging
//
//  Created by 순진이 on 2022/08/04.
//

import UIKit

protocol TabViewDelegate: AnyObject {
    func didMoveToTab(at index: Int)
}

class TabView: UIView {

    enum SizeConfiguration {
        case fillEqually(height: CGFloat, spacing: CGFloat = 0)
        case fixed(width: CGFloat, height: CGFloat, spacing: CGFloat = 0)
        
        var height: CGFloat {
            switch self {
            case let .fillEqually(height, _):
                return height
            case let .fixed(_, height, _):
                return height
            }
        }
    }

    init(sizeConfiguration: SizeConfiguration, tabs: [TabItemProtocol] = []) {
        self.sizeConfiguration = sizeConfiguration
        self.tabs = tabs
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: TabViewDelegate?
    public let sizeConfiguration: SizeConfiguration
    private var currentlySelectedIndex: Int = 0
    
    public var tabs: [TabItemProtocol] {
        didSet {
            print(tabs)
            self.collectionView.reloadData()
            self.tabs[currentlySelectedIndex].onSelected()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero // cell size가 맞춰서 조정됨
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TabCollectionViewCell.self, forCellWithReuseIdentifier: "TabCollectionViewCell")
        return collectionView
    }()
    
    func setupUI() {
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func moveToTap(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.currentlySelectedIndex = index
    }
}

extension TabView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.identifier, for: indexPath) as! TabCollectionViewCell
        cell.view = tabs[indexPath.item]
        return cell
    }
}


extension TabView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch sizeConfiguration {
        case let .fillEqually(height, spacing):
            let totalWidth = self.frame.width
            let widthPerItem = (totalWidth - (spacing * CGFloat((self.tabs.count + 1)))) / CGFloat(self.tabs.count)
            return CGSize(width: widthPerItem, height: height)
        case let .fixed(width: width, height: height, spacing: spacing):
            return CGSize(width: width - (spacing * 2), height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch sizeConfiguration {
        case let .fillEqually(_, spacing: spacing), let .fixed(_, _, spacing):
            return spacing
            
        }
    }
}

extension TabView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moveToTap(at: indexPath.item)
        self.delegate?.didMoveToTab(at: indexPath.item)
    }
}
