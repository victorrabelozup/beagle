//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

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
    
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let view = FormSubmitView(enabled: enabled, frame: .zero, dependencies: dependencies)
        let childView = child.toView(context: context, dependencies: dependencies)
        view.addSubview(childView)
        dependencies.flex.enableYoga(true, for: childView)
        view.beagleFormElement = self
        return view
    }
    
    final class FormSubmitView: UIView, Observer, WidgetStateObservable {
        var observable: Observable<WidgetState> = Observable<WidgetState>(value: WidgetState(value: nil))
        private var dependencies: Renderable.Dependencies?
        
        init(
            enabled: Bool?,
            frame: CGRect,
            dependencies: Renderable.Dependencies?
        ) {
            observable.value = WidgetState(value: enabled)
            self.dependencies = dependencies
            super.init(frame: .zero)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func didChangeValue(_ value: Any?) {
            guard let button = self.subviews.first as? Button.BeagleUIButton,
                let state = value as? WidgetState,
                let enabled = state.value as? Bool else {
                return
            }
            button.isEnabled = enabled ? true : false
            if let style = button.style {
                dependencies?.theme.applyStyle(for: button as UIButton, withId: style)
            }
            
        }
    }
}
