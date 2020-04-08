/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

// MARK: - Model
extension ListViewUIComponent {
    struct Model {
        let component: ListView
        var componentViews: [(view: UIView, size: CGSize)]
    }
}

final class ListViewUIComponent: UIView {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        switch model.component.direction {
        case .horizontal:
            let width = min(size.width, model.componentViews.reduce(0, { $0 + $1.size.width }))
            let height = min(size.height, model.componentViews.max(by: { $0.size.height < $1.size.height })?.size.height ?? 0)
            return CGSize(width: width, height: height)
        case .vertical:
            let height = min(size.height, model.componentViews.reduce(0, { $0 + $1.size.height }))
            let width = min(size.width, model.componentViews.max(by: { $0.size.width < $1.size.width })?.size.width ?? 0)
            return CGSize(width: width, height: height)
        }
    }
    
    // MARK: - UIComponents
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = model.component.direction.toUIKit()
        let collection = UICollectionView(
            frame: bounds,
            collectionViewLayout: layout
        )
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    // MARK: - Properties

    private let model: Model
    
    // MARK: - Initialization
    
    init(
        frame: CGRect = .zero,
        model: Model
    ) {
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
        setupCollectionView()
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.register(ListItemCollectionViewCell.self, forCellWithReuseIdentifier: ListItemCollectionViewCell.className)
        constrainCollectionView()
    }

    private func constrainCollectionView() {
        addSubview(collectionView)
        collectionView.anchorTo(superview: self)
    }
    
}

// MARK: - UICollectionViewDataSource
extension ListViewUIComponent: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.componentViews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListItemCollectionViewCell.className,
            for: indexPath
        )
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let componentView = model.componentViews[indexPath.row]
        (cell as? ListItemCollectionViewCell)?.setup(with: componentView.view)
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let componentView = model.componentViews[indexPath.row]
        componentView.view.removeFromSuperview()
    }
    
}

// MARK: - UICollectionViewDelegate
extension ListViewUIComponent: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = model.componentViews[indexPath.row].size
        switch model.component.direction {
        case .horizontal:
            return CGSize(width: size.width, height: bounds.height)
        case .vertical:
            return CGSize(width: bounds.width, height: size.height)
        }
    }
    
}
