//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

struct ScreenComponent: ServerDrivenComponent {

    // MARK: - Public Properties
    
    public let safeArea: SafeArea?
    public let navigationBar: NavigationBar?
    public let header: ServerDrivenComponent?
    public let content: ServerDrivenComponent
    public let footer: ServerDrivenComponent?
    
    // MARK: - Initialization
    
    public init(
        safeArea: SafeArea? = nil,
        navigationBar: NavigationBar? = nil,
        header: ServerDrivenComponent? = nil,
        content: ServerDrivenComponent,
        footer: ServerDrivenComponent? = nil
    ) {
        self.safeArea = safeArea
        self.navigationBar = navigationBar
        self.header = header
        self.content = content
        self.footer = footer
    }
}

extension ScreenComponent: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {

        prefetch(dependencies: dependencies)
        
        guard let beagleController = context as? BeagleScreenViewController,
            beagleController.screenController.navigationController == nil else {
                return createComponentContentView(context: context, dependencies: dependencies)
        }
        
        let contentController = BeagleScreenViewController(
            viewModel: .init(
                screenType: .declarative(toScreen()),
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
    
    private func prefetch(dependencies: RenderableDependencies) {
        navigationBar?.navigationBarItems?
            .compactMap { $0.action as? Navigate }
            .compactMap { $0.newPath }
            .forEach { dependencies.preFetchHelper.prefetchComponent(newPath: $0, dependencies: dependencies) }
    }
    
    private func createComponentContentView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let headerView = header?.toView(context: context, dependencies: dependencies)
        let footerView = footer?.toView(context: context, dependencies: dependencies)
        let contentView = buildContentView(context: context, dependencies: dependencies)
        
        if headerView == nil && footerView == nil {
            return contentView
        }
        
        let container = UIView()
        
        if let headerView = headerView {
            container.addSubview(headerView)
            headerView.flex.isEnabled = true
        }
        
        container.addSubview(contentView)
        contentView.flex.isEnabled = true
        
        if let footerView = footerView {
            container.addSubview(footerView)
            footerView.flex.isEnabled = true
        }
        
        return container
    }
    
    private func buildContentView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let contentHolder = UIView()
        let contentView = content.toView(context: context, dependencies: dependencies)
        
        contentHolder.addSubview(contentView)
        contentHolder.flex.setupFlex(Flex(grow: 1))
        contentView.flex.isEnabled = true
        
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
    public let navigationBarItems: [NavigationBarItem]?

    // MARK: - Initialization

    public init(
        title: String,
        style: String? = nil,
        showBackButton: Bool? = nil,
        navigationBarItems: [NavigationBarItem]? = nil
    ) {
        self.title = title
        self.style = style
        self.showBackButton = showBackButton
        self.navigationBarItems = navigationBarItems
    }
}

public struct NavigationBarItem {
    
    // MARK: - Public Properties
    
    public let image: String?
    public let text: String
    public let action: Action
    
    public init(
        image: String? = nil,
        text: String,
        action: Action
    ) {
        self.image = image
        self.text = text
        self.action = action
    }
}

extension NavigationBarItem {
    
    public func toBarButtonItem(
        context: BeagleContext,
        dependencies: RenderableDependencies
    ) -> UIBarButtonItem {
        return NavigationBarButtonItem(barItem: self, context: context, dependencies: dependencies)
    }
    
    final private class NavigationBarButtonItem: UIBarButtonItem {
        
        private let barItem: NavigationBarItem
        private weak var context: BeagleContext?
        
        init(
            barItem: NavigationBarItem,
            context: BeagleContext,
            dependencies: RenderableDependencies
        ) {
            self.barItem = barItem
            self.context = context
            super.init()
            if let imageName = barItem.image {
                image = UIImage(named: imageName, in: dependencies.appBundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
                accessibilityHint = barItem.text
            } else {
                title = barItem.text
            }
            target = self
            action = #selector(triggerAction)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc private func triggerAction() {
            context?.doAction(barItem.action, sender: self)
        }
    }
}
