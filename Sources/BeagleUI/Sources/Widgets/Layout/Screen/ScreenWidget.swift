//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct ScreenWidget: Widget {

    // MARK: - Public Properties
    
    public let safeArea: SafeArea?
    public let navigationBar: NavigationBar?
    public let header: Widget?
    public let content: Widget
    public let footer: Widget?
    
    // MARK: - Initialization
    
    public init(
        safeArea: SafeArea? = nil,
        navigationBar: NavigationBar? = nil,
        header: Widget? = nil,
        content: Widget,
        footer: Widget? = nil
    ) {
        self.safeArea = safeArea
        self.navigationBar = navigationBar
        self.header = header
        self.content = content
        self.footer = footer
    }
}

extension ScreenWidget: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        guard let beagleController = context as? BeagleScreenViewController,
            beagleController.screenController.navigationController == nil else {
                return createWidgetContentView(context: context, dependencies: dependencies)
        }
        
        let contentController = BeagleScreenViewController(
            viewModel: .init(
                screenType: .declarative(self),
                dependencies: beagleController.viewModel.dependencies,
                delegate: beagleController.viewModel.delegate
            )
        )
        let navigationController = UINavigationController(rootViewController: contentController)
        
        beagleController.addChildViewController(navigationController)
        DispatchQueue.main.async {
            navigationController.didMove(toParentViewController: beagleController)
        }
        return navigationController.view
    }

    // MARK: - Private Functions
    
    private func createWidgetContentView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let headerView = header?.toView(context: context, dependencies: dependencies)
        let footerView = footer?.toView(context: context, dependencies: dependencies)
        let contentView = buildContentView(context: context, dependencies: dependencies)
        
        if headerView == nil && footerView == nil {
            return contentView
        }
        
        let container = UIView()
        
        if let headerView = headerView {
            container.addSubview(headerView)
            dependencies.flex.enableYoga(true, for: headerView)
        }
        
        container.addSubview(contentView)
        dependencies.flex.enableYoga(true, for: contentView)
        
        if let footerView = footerView {
            container.addSubview(footerView)
            dependencies.flex.enableYoga(true, for: footerView)
        }
        
        return container
    }
    
    private func buildContentView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let contentHolder = UIView()
        let contentView = content.toView(context: context, dependencies: dependencies)
        
        contentHolder.addSubview(contentView)
        dependencies.flex.setupFlex(Flex(grow: 1), for: contentHolder)
        dependencies.flex.enableYoga(true, for: contentView)
        
        return contentHolder
    }
}

public struct SafeArea: Equatable {

    // MARK: - Public Properties

    public let top: Bool?
    public let leading: Bool?
    public let bottom: Bool?
    public let trailing: Bool?

    // MARK: - Initialization

    public init(
        top: Bool? = nil,
        leading: Bool? = nil,
        bottom: Bool? = nil,
        trailing: Bool? = nil
    ) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
    
    public static var all: SafeArea {
        return SafeArea(top: true, leading: true, bottom: true, trailing: true)
    }
    
    public static var none: SafeArea {
        return SafeArea(top: false, leading: false, bottom: false, trailing: false)
    }
}

public struct NavigationBar {

    // MARK: - Public Properties

    public let title: String
    public let style: String?
    public let showBackButton: Bool?

    // MARK: - Initialization

    public init(
        title: String,
        style: String? = nil,
        showBackButton: Bool? = nil
    ) {
        self.title = title
        self.style = style
        self.showBackButton = showBackButton
    }
}
