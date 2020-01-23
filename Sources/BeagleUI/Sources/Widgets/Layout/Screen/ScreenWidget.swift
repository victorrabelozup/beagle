//
//  Copyright © 2019 Zup IT. All rights reserved.
//

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
}

public struct NavigationBar {

    // MARK: - Public Properties

    public let title: String
    public let showBackButton: Bool?

    // MARK: - Initialization

    public init(
        title: String,
        showBackButton: Bool? = nil
    ) {
        self.title = title
        self.showBackButton = showBackButton
    }
}
