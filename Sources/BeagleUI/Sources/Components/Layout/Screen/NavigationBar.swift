//
//  Copyright © 05/03/20 Zup IT. All rights reserved.
//

import Foundation
import UIKit

public struct NavigationBar: Decodable {

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

extension NavigationBarItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case image
        case text
        case action
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.text = try container.decode(String.self, forKey: .text)
        self.action = try container.decode(forKey: .action)
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
