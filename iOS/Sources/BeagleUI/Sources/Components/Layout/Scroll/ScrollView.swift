/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public struct ScrollView: AppearanceComponent {
    
    // MARK: - Public Properties
    
    public let children: [ServerDrivenComponent]
    public let scrollDirection: ScrollAxis?
    public let scrollBarEnabled: Bool?
    public let appearance: Appearance?
    
    // MARK: - Initialization

    public init(
        children: [ServerDrivenComponent],
        scrollDirection: ScrollAxis? = nil,
        scrollBarEnabled: Bool? = nil,
        appearance: Appearance? = nil
    ) {
        self.children = children
        self.scrollDirection = scrollDirection
        self.scrollBarEnabled = scrollBarEnabled
        self.appearance = appearance
    }
    
}

public enum ScrollAxis: String, Decodable {
    case vertical = "VERTICAL"
    case horizontal = "HORIZONTAL"
    
    var flexDirection: Flex.FlexDirection {
        switch self {
        case .vertical:
            return .column
        case .horizontal:
            return .row
        }
    }
}

extension ScrollView: Decodable {
    enum CodingKeys: String, CodingKey {
        case children
        case scrollDirection
        case scrollBarEnabled
        case appearance
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.children = try container.decode(forKey: .children)
        self.scrollDirection = try container.decodeIfPresent(ScrollAxis.self, forKey: .scrollDirection)
        self.scrollBarEnabled = try container.decodeIfPresent(Bool.self, forKey: .scrollBarEnabled)
        self.appearance = try container.decodeIfPresent(Appearance.self, forKey: .appearance)
    }
}

extension ScrollView: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let scrollBarEnabled = self.scrollBarEnabled ?? true
        let flexDirection = (scrollDirection ?? .vertical).flexDirection
        let scrollView = BeagleContainerScrollView()
        let contentView = UIView()
        
        children.forEach {
            let childView = $0.toView(context: context, dependencies: dependencies)
            contentView.addSubview(childView)
            childView.flex.isEnabled = true
        }
        scrollView.addSubview(contentView)
        scrollView.beagle.setup(appearance: appearance)
        scrollView.flex.setup(Flex(flexDirection: flexDirection, grow: 1))
        scrollView.showsVerticalScrollIndicator = scrollBarEnabled
        scrollView.showsHorizontalScrollIndicator = scrollBarEnabled
        scrollView.yoga.overflow = .scroll
        
        let flexContent = Flex(flexDirection: flexDirection, grow: 0, shrink: 0)
        contentView.flex.setup(flexContent)
        
        return scrollView
    }
}

final class BeagleContainerScrollView: UIScrollView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if let contentView = subviews.first {
            contentSize = contentView.frame.size
        }
    }
}
