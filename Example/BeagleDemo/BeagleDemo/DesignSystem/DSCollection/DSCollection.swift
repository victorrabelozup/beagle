//
//  Collection.swift
//  BeagleDemo
//
//  Created by Yan Dias on 27/02/20.
//  Copyright © 2020 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct DSCollectionDataSource : Decodable{
    
    struct Card : Decodable {
        let name: String
        let age: Int
    }
    
    let cards: [Card]
}

struct DSCollection: Widget {
    var id: String?
    
    var appearance: Appearance?
    var flex: Flex?
    var accessibility: Accessibility?
    let dataSource: DSCollectionDataSource

    init(
        appearance: Appearance? = nil,
        flex: Flex? = nil,
        accessibility: Accessibility? = nil,
        dataSource: DSCollectionDataSource
    ) {
        self.appearance = appearance
        self.flex = flex
        self.accessibility = accessibility
        self.dataSource = dataSource
    }
}

struct DSCollectionEntity: WidgetEntity {
    var flex: FlexEntity?
    var appearance: AppearanceEntity?
    var accessibility: AccessibilityEntity?
    
    let dataSource: DSCollectionDataSource
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let flex = try self.flex?.mapToUIModel()
        return DSCollection(flex: flex, dataSource: dataSource)
    }
}

extension DSCollection: Renderable {

    func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let view = DSCollectionUIComponent(dataSource: dataSource)
        view.flex.setupFlex(flex)
        return view
    }
}

