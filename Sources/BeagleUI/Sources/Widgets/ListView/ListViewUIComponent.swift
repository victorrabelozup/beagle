//
//  ListViewUIComponent.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit
import YogaKit

// MARK: - Model
extension ListViewUIComponent {
    struct Model {
        let widget: ListView
        let widgetViews: [UIView]
    }
}

final class ListViewUIComponent: UIView {
    
    // MARK: - UIComponents
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(
            frame: bounds,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    // MARK: - Properties
    
    private let flexViewConfigurator: FlexViewConfiguratorProtocol
    private let model: Model
    
    // MARK: - Initialization
    
    init(
        frame: CGRect = .zero,
        flexViewConfigurator: FlexViewConfiguratorProtocol,
        model: Model
    ) {
        self.flexViewConfigurator = flexViewConfigurator
        self.model = model
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .white
        setupCollectionView()
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        setupCollectionViewLayout()
        collectionView.register(ListItemCollectionViewCell.self, forCellWithReuseIdentifier: ListItemCollectionViewCell.className)
        constrainCollectionView()
    }
    
    private func setupCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = model.widget.direction.toUIKit()
        flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func constrainCollectionView() {
        addSubview(collectionView)
        collectionView.anchorTo(superview: self)
    }
    
}

// MARK: - UICollectionViewDataSource
extension ListViewUIComponent: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.widgetViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let widgetView = model.widgetViews[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListItemCollectionViewCell.className,
            for: indexPath
        ) as? ListItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: widgetView)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension ListViewUIComponent: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widgetView = model.widgetViews[indexPath.row]
        let size = widgetView.sizeThatFits(CGSize(width: CGFloat.infinity, height: CGFloat.infinity))
        return size
    }
    
}
