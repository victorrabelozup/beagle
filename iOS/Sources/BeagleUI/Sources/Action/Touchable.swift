/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public struct Touchable: ServerDrivenComponent, ClickedOnComponent {
    // MARK: - Public Properties
    public let clickAnalyticsEvent: AnalyticsClick?
    public let action: Action
    public let child: ServerDrivenComponent
    
    // MARK: - Initialization
    
    public init(
        action: Action,
        clickAnalyticsEvent: AnalyticsClick? = nil,
        child: ServerDrivenComponent
    ) {
        self.action = action
        self.child = child
        self.clickAnalyticsEvent = clickAnalyticsEvent
    }
}

extension Touchable: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        var events: [Event] = [.action(action)]
        if let clickAnalyticsEvent = clickAnalyticsEvent {
            events.append(.analytics(clickAnalyticsEvent))
        }
        
        context.register(events: events, inView: childView)
        prefetchComponent(context: context, dependencies: dependencies)
        return childView
    }
    
    private func prefetchComponent(context: BeagleContext, dependencies: RenderableDependencies) {
        guard let newPath = (action as? Navigate)?.newPath else { return }
        dependencies.preFetchHelper.prefetchComponent(newPath: newPath, dependencies: dependencies)
    }
}

extension Touchable: Decodable {
    enum CodingKeys: String, CodingKey {
        case action
        case child
        case clickAnalyticsEvent
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.action = try container.decode(forKey: .action)
        self.child = try container.decode(forKey: .child)
        self.clickAnalyticsEvent = try container.decodeIfPresent(AnalyticsClick.self, forKey: .clickAnalyticsEvent)
    }
}
