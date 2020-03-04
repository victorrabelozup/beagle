//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct ListView: ServerDrivenComponent {
    
    // MARK: - Public Properties
    
    public let rows: [ServerDrivenComponent]?
    public let direction: Direction
    
    // MARK: - Initialization
    
    public init(
        rows: [ServerDrivenComponent]? = nil,
        direction: Direction = .vertical
    ) {
        self.rows = rows
        self.direction = direction
    }
}

extension ListView {
    
    public enum Direction: String, StringRawRepresentable {
        
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
        let componentViews: [(view: UIView, size: CGSize)] = rows?.compactMap {
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
        } ?? []
    
        let model = ListViewUIComponent.Model(
            component: self,
            componentViews: componentViews
        )
        
        return ListViewUIComponent(model: model)
    }
}
