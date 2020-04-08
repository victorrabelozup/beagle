/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public struct FormSubmit: ServerDrivenComponent {
    
    // MARK: - Public Properties
    public let child: ServerDrivenComponent
    public var enabled: Bool?
    
    // MARK: - Initialization
    
    public init(
        child: ServerDrivenComponent,
        enabled: Bool? = nil
    ) {
        self.child = child
        self.enabled = enabled
    }
    
}

extension FormSubmit: Renderable {
    
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        childView.flex.isEnabled = true
        childView.beagleFormElement = self
        
        let view = FormSubmitView(childView: childView, enabled: enabled, dependencies: dependencies)
        return view
    }
    
    final class FormSubmitView: UIView, Observer, WidgetStateObservable {
        
        let childView: UIView
        let observable: Observable<WidgetState>
        private var dependencies: RenderableDependencies?
        
        init(
            childView: UIView,
            enabled: Bool?,
            dependencies: RenderableDependencies?
        ) {
            self.childView = childView
            self.observable = Observable(value: WidgetState(value: enabled))
            self.dependencies = dependencies
            super.init(frame: .zero)
            addSubview(childView)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func didChangeValue(_ value: Any?) {
            childView.gestureRecognizers?
                .compactMap { $0 as? SubmitFormGestureRecognizer }
                .forEach { $0.updateSubmitView() }
        }
    }
}

extension FormSubmit: Decodable {
    enum CodingKeys: String, CodingKey {
        case child
        case enabled
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.child = try container.decode(forKey: .child)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
    }
}
