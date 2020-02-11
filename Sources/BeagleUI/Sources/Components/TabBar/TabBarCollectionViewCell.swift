//
//  TabBarUIComponentCollectionViewCell.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 22/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class TabBarCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIComponents
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.invalidateIntrinsicContentSize()
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(stackView)
        stackView.anchorTo(superview: contentView)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupTab(with tab: TabItem) {
        switch contentVerification(tabItem: tab) {
        case let .both(iconName, text):
            icon.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
            title.text = text
            icon.image = UIImage(named: iconName)
            title.font = UIFont.systemFont(ofSize: 13)
            icon.isHidden = false
            title.isHidden = false

        case .icon(let iconName):
            icon.widthAnchor.constraint(lessThanOrEqualToConstant: 35).isActive = true
            icon.image = UIImage(named: iconName)
            icon.isHidden = false
            title.isHidden = true

        case .title(let text):
            title.isHidden = false
            icon.isHidden = true
            title.sizeToFit()
            title.text = text

        case .none:
            title.isHidden = true
            icon.isHidden = true
        }
    }

    private func contentVerification(tabItem: TabItem) -> ContentEnabler {
        switch (tabItem.icon, tabItem.title) {
        case let (icon?, title?):
            return .both(icon: icon, title: title)
        case let (_, title?):
            return .title(title)
        case let (icon?, _):
            return .icon(icon)
        default:
            return .none
        }
    }
    
    private enum ContentEnabler {
        case icon(String)
        case title(String)
        case both(icon: String, title: String)
        case none
    }
}
