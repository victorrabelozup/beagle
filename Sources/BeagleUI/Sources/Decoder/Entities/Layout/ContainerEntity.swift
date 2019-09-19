//
//  ContainerEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Container`
struct ContainerEntity: WidgetEntity {//, WidgetConvertible {
    
//    typealias WidgetType = Container
    
    let body: WidgetEntityContainer?
    let content: WidgetEntityContainer
    let footer: WidgetEntityContainer?
    
//    func mapToWidget() -> Container {
//        let body: Widget? = convertBody()
//        let content: Widget = convertContent()
//        let footer: Widget? = convertFooter()
//        return Container(
//            body: body,
//            content: content,
//            footer: footer
//        )
//    }

//    private func convertBody() -> Widget? {
//        guard let type = body?.type else { return nil }
//        switch type {
//        case "beagle:Container":
////            return Container(body: <#T##Widget?#>, content: <#T##Widget#>, footer: <#T##Widget?#>)
//        default:
//            return nil
//        }
//    }
//
//    private func convertContent() -> Widget {
//
//    }
//
//    private func convertFooter() -> Widget? {
//
//    }
    
}

//WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "container"))
//WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "body"))
//WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "footer"))
//WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "content"))
//WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "children"))
//WidgetEntityContainer.register(TextEntity.self, for: decodingKey(for: "text"))
