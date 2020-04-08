/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation
import UIKit

public struct NavigationBar: Decodable {

    // MARK: - Public Properties

    public let title: String
    public let style: String?
    public let showBackButton: Bool?
    public let backButtonAccessibility: Accessibility?
    public let navigationBarItems: [NavigationBarItem]?

    // MARK: - Initialization

    public init(
        title: String,
        style: String? = nil,
        showBackButton: Bool? = nil,
        backButtonAccessibility: Accessibility? = nil,
        navigationBarItems: [NavigationBarItem]? = nil
    ) {
        self.title = title
        self.style = style
        self.showBackButton = showBackButton
        self.backButtonAccessibility = backButtonAccessibility
        self.navigationBarItems = navigationBarItems
    }
}

public struct NavigationBarItem {
    
    // MARK: - Public Properties
    
    public let id: String?
    public let image: String?
    public let text: String
    public let action: Action
    public let accessibility: Accessibility?

    public init(
        id: String? = nil,
        image: String? = nil,
        text: String,
        action: Action,
        accessibility: Accessibility? = nil
    ) {
        self.id = id
        self.image = image
        self.text = text
        self.action = action
        self.accessibility = accessibility
    }
}

extension NavigationBarItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case text
        case action
        case accessibility
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.text = try container.decode(String.self, forKey: .text)
        self.action = try container.decode(forKey: .action)
        self.accessibility = try container.decodeIfPresent(Accessibility.self, forKey: .accessibility)
    }
}

extension NavigationBarItem {
    
    public func toBarButtonItem(
        context: BeagleContext,
        dependencies: RenderableDependencies
    ) -> UIBarButtonItem {
        let barButtonItem = NavigationBarButtonItem(barItem: self, context: context, dependencies: dependencies)
        return barButtonItem
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
            accessibilityIdentifier = barItem.id
            target = self
            action = #selector(triggerAction)
            ViewConfigurator.applyAccessibility(barItem.accessibility, to: self)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc private func triggerAction() {
            context?.doAction(barItem.action, sender: self)
        }
    }
}
