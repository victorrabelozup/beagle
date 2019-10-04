//
//  WidgetBuilders.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 01/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

@_functionBuilder
public final class WidgetBuilder {

    public static func buildBlock(_ widget: Widget) -> Widget {
        let widgetToReturn = widget
        return widgetToReturn
    }

}

@_functionBuilder
public final class WidgetArrayBuilder {

    public static func buildBlock(_ children: Widget...) -> [Widget] {
        var array = [Widget]()
        children.forEach { array.append($0) }
        return array
    }

}
