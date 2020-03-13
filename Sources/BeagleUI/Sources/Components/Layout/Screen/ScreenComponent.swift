//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

struct ScreenComponent: AppearanceComponent {

    // MARK: - Public Properties
    
    public let identifier: String?
    public let appearance: Appearance?
    public let safeArea: SafeArea?
    public let navigationBar: NavigationBar?
    public let header: ServerDrivenComponent?
    public let child: ServerDrivenComponent
    public let footer: ServerDrivenComponent?
    
    // MARK: - Initialization
    
    public init(
        identifier: String? = nil,
        appearance: Appearance? = nil,
        safeArea: SafeArea? = nil,
        navigationBar: NavigationBar? = nil,
        header: ServerDrivenComponent? = nil,
        child: ServerDrivenComponent,
        footer: ServerDrivenComponent? = nil
    ) {
        self.identifier = identifier
        self.appearance = appearance
        self.safeArea = safeArea
        self.navigationBar = navigationBar
        self.header = header
        self.child = child
        self.footer = footer
    }
}

extension ScreenComponent: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {

        prefetch(dependencies: dependencies)
        
        guard let beagleController = context as? BeagleScreenViewController,
            beagleController.screenController.navigationController == nil
        else {
            let contentView = createComponentContentView(context: context, dependencies: dependencies)
            contentView.beagle.setup(appearance: appearance)
            return contentView
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
        let childView = buildChildView(context: context, dependencies: dependencies)
        
        if headerView == nil && footerView == nil {
            return childView
        }
        
        let container = UIView()
        
        if let headerView = headerView {
            container.addSubview(headerView)
            headerView.flex.isEnabled = true
        }
        
        container.addSubview(childView)
        childView.flex.isEnabled = true
        
        if let footerView = footerView {
            container.addSubview(footerView)
            footerView.flex.isEnabled = true
        }
        
        return container
    }
    
    private func buildChildView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let childHolder = UIView()
        let childView = child.toView(context: context, dependencies: dependencies)
        
        childHolder.addSubview(childView)
        childHolder.flex.setup(Flex(grow: 1))
        childView.flex.isEnabled = true
        
        return childHolder
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
