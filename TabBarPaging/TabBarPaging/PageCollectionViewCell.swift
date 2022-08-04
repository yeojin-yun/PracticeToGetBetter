//
//  PageCollectionViewCell.swift
//  TabBarPaging
//
//  Created by 순진이 on 2022/08/04.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PageCollectionViewCell"
    
    public var view: UIView? {
        didSet {
            setupUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        guard let view = view else { return }
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}
