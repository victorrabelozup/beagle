/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public struct ListView: ServerDrivenComponent {
    
    // MARK: - Public Properties
    
    public let rows: [ServerDrivenComponent]
    public let direction: Direction
    
    // MARK: - Initialization
    
    public init(
        rows: [ServerDrivenComponent],
        direction: Direction = .vertical
    ) {
        self.rows = rows
        self.direction = direction
    }
}

extension ListView {
    
    public enum Direction: String, Decodable {
        
        case vertical = "VERTICAL"
        case horizontal = "HORIZONTAL"

        func toUIKit() -> UICollectionView.ScrollDirection {
            switch self {
            case .horizontal:
                return .horizontal
            case .vertical:
                return .vertical
            }
        }
    }
}

extension ListView: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let componentViews: [(view: UIView, size: CGSize)] = rows.compactMap {
            let container = Container(children: [$0], flex: Flex(positionType: .absolute))
            let containerView = container.toView(context: context, dependencies: dependencies)
            let view = UIView()
            view.addSubview(containerView)
            view.flex.applyLayout()
            if let view = containerView.subviews.first {
                view.removeFromSuperview()
                return (view: view, size: view.bounds.size)
            }
            return nil
        }
    
        let model = ListViewUIComponent.Model(
            component: self,
            componentViews: componentViews
        )
        
        return ListViewUIComponent(model: model)
    }
}

extension ListView: Decodable {
    enum CodingKeys: String, CodingKey {
        case rows
        case direction
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rows = try container.decode(forKey: .rows)
        self.direction = try container.decode(Direction.self, forKey: .direction)
    }
}
