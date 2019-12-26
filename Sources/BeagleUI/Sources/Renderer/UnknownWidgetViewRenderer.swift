//
//  UnknownWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public final class UnknownWidgetViewRenderer: ViewRenderer {

    let widget: AnyWidget
    let dependencies: Dependencies
    
    public init(
        widget: Widget,
        dependencies: Dependencies
    ) throws {
        self.widget = AnyWidget(value: widget as Any)
        self.dependencies = dependencies
    }

    convenience init(widget: Widget) {
        try! self.init(widget: widget, dependencies: Beagle.dependencies)
    }

    private(set) lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.text = "Unknown Widget of type:\n \(String(describing: widget))"
        label.textColor = .red
        label.backgroundColor = .yellow
        return label
    }()
    
    // MARK: - Public Functions
    
    public func buildView(context: BeagleContext) -> UIView {
        return label
    }
    
}
