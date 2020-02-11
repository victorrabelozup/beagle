//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct ListView: ServerDrivenComponent {
    
    // MARK: - Public Properties
    
    public let rows: [ServerDrivenComponent]?
    public let remoteDataSource: String?
    public let loadingState: ServerDrivenComponent?
    public let direction: Direction
    
    // MARK: - Initialization
    
    public init(
        rows: [ServerDrivenComponent]? = nil,
        remoteDataSource: String? = nil,
        loadingState: ServerDrivenComponent? = nil,
        direction: Direction = .vertical
    ) {
        self.rows = rows
        self.remoteDataSource = remoteDataSource
        self.loadingState = loadingState
        self.direction = direction
    }
    
    // MARK: - Configuration
    
    public func remoteDataSource(_ remoteDataSource: String) -> ListView {
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
    
    public func loadingState(_ loadingStateBuilder: () -> ServerDrivenComponent) -> ListView {
        let loadingState = loadingStateBuilder()
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
    
    public func direction(_ direction: Direction) -> ListView {
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
}

extension ListView {
    
    public enum Direction {
        
        case vertical
        case horizontal
        
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
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let componentViews = rows?
            .compactMap {
                $0.toView(context: context, dependencies: dependencies)
            } ?? []
    
        let model = ListViewUIComponent.Model(
            component: self,
            componentViews: componentViews
        )
        
        let listView = ListViewUIComponent(flexViewConfigurator: dependencies.flex, model: model)
        
        let flex = Flex(grow: 1)
        dependencies.flex.setupFlex(flex, for: listView)
        dependencies.flex.enableYoga(true, for: listView)
        
        return listView
    }
}
