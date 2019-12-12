//
//  UnknownWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public final class UnknownWidgetViewRenderer: WidgetViewRendererProtocol {

    let widget: AnyWidget
    let dependencies: RendererDependencies
    
    public init(widget: Widget, dependencies: RendererDependencies?) throws {
        self.widget = AnyWidget(value: widget as Any)
        self.dependencies = dependencies ?? BeagleEnvironment.shared
    }

    convenience init(widget: Widget) {
        try! self.init(widget: widget, dependencies: nil)
    }
    
    // MARK: - Public Functions
    
    public func buildView(context: BeagleContext) -> UIView {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.text = "Unknown Widget of type:\n \(String(describing: widget))"
        label.textColor = .red
        label.backgroundColor = .yellow

        return label
    }
    
}
