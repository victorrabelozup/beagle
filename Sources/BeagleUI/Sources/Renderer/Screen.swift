//
//  Copyright © 06/02/20 Zup IT. All rights reserved.
//

import UIKit

public struct Screen {
    
    // MARK: - Public Properties
    
    public let identifier: String?
    public let appearance: Appearance?
    public let safeArea: SafeArea?
    public let navigationBar: NavigationBar?
    public let header: ServerDrivenComponent?
    public let child: ServerDrivenComponent
    public let footer: ServerDrivenComponent?
    
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
    
    func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        return ScreenComponent(
            identifier: identifier,
            appearance: appearance,
            safeArea: safeArea,
            navigationBar: navigationBar,
            header: header,
            child: child,
            footer: footer
        ).toView(context: context, dependencies: dependencies)
    }
}
