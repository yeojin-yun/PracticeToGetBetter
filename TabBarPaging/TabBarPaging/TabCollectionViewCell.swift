//
//  TabCollectionViewCell.swift
//  TabBarPaging
//
//  Created by 순진이 on 2022/08/04.
//

import UIKit

protocol TabItemProtocol: UIView {
    func onSelected()
    func onNotSelected()
}

class TabCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TabCollectionViewCell"
    
    var leadingContraints = NSLayoutConstraint()
    var topContraints = NSLayoutConstraint()
    var trailingContraints = NSLayoutConstraint()
    var bottomContraints = NSLayoutConstraint()
    
    public var view: TabItemProtocol? {
        didSet {
            self.setupUI()
        }
    }
    
    public var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            leadingContraints.constant = contentInsets.left
            topContraints.constant = contentInsets.top
            trailingContraints.constant = -contentInsets.right
            bottomContraints.constant = -contentInsets.bottom
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
        
        leadingContraints = view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: contentInsets.left)
        topContraints = view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: contentInsets.top)
        trailingContraints = view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -contentInsets.right)
        bottomContraints = view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -contentInsets.bottom)
        
        NSLayoutConstraint.activate([
            leadingContraints,
            topContraints,
            trailingContraints,
            bottomContraints
            
        ])
    }
}
