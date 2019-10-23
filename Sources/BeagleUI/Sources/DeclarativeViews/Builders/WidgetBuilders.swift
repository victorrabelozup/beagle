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

    public static func buildBlock(_ widget: Widget) -> Widget { return widget }
    
    public static func buildIf(_ children: Widget?) -> Widget? { return children }
    
    public static func buildEither(first: Widget) -> Widget { return first }
    
    public static func buildEither(second: Widget) -> Widget { return second }

}

@_functionBuilder
public final class WidgetArrayBuilder {

    public static func buildBlock(_ children: Widget...) -> [Widget] { return children }
    
}
