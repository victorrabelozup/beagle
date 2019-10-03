//
//  Container.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Container: Widget {
    
    public let header: Widget?
    public let content: Widget
    public let footer: Widget?
    
    init(
        header: Widget? = nil,
        content: Widget,
        footer: Widget? = nil
    ) {
        self.header = header
        self.content = content
        self.footer = footer
    }
    
    public init(
        header headerBuilder: (() -> Widget?)? = nil,
        content contentBuilder: () -> Widget,
        footer footerBuilder: (() -> Widget?)? = nil
    ) {
        header = headerBuilder?()
        content = contentBuilder()
        footer = footerBuilder?()
    }
    
}
