/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public struct Container: Widget {
    
    // MARK: - Public Properties
    public let children: [ServerDrivenComponent]
    
    public var id: String?
    public let flex: Flex?
    public let appearance: Appearance?
    public let accessibility: Accessibility?
    
    // MARK: - Initialization
    
    public init(
        children: [ServerDrivenComponent],
        id: String? = nil,
        flex: Flex? = nil,
        appearance: Appearance? = nil,
        accessibility: Accessibility? = nil
    ) {
        self.children = children
        self.id = id
        self.flex = flex
        self.appearance = appearance
        self.accessibility = accessibility
    }
    
   // MARK: - Configuration
    
    public func applyFlex(_ flex: Flex) -> Container {
        return Container(children: children, flex: flex, appearance: appearance)
    }
}

extension Container: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let containerView = UIView()
        
        children.forEach {
            let childView = $0.toView(context: context, dependencies: dependencies)
            containerView.addSubview(childView)
            childView.flex.isEnabled = true
        }

        containerView.beagle.setup(self)
        
        return containerView
    }
}

extension Container: Decodable {
    enum CodingKeys: String, CodingKey {
        case children
        case id
        case flex
        case appearance
        case accessibility
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.children = try container.decode(forKey: .children)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.flex = try container.decodeIfPresent(Flex.self, forKey: .flex)
        self.appearance = try container.decodeIfPresent(Appearance.self, forKey: .appearance)
        self.accessibility = try container.decodeIfPresent(Accessibility.self, forKey: .accessibility)
    }
}
