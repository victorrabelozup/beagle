//
//  TextWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class TextWidgetViewRenderer: WidgetViewRenderer<Text> {
    
    override func buildView() -> UIView {
        
        let label = UILabel(frame: .init(x: 0, y: 0, width: 100, height: 100))
        label.text = widget.text
        label.backgroundColor = .red
        label.sizeToFit()
        
//        let flex = Flex(
////            direction: .inherit,
////            flexDirection: .row,
////            justifyContent: .flexStart,
////            alignItems: .stretch,
////            alignSelf: .auto,
////            alignContent: .stretch,
//            size: .init(
//                width: .init(value: 100, type: .real),
//                height: .init(value: 100, type: .real)
//            )
//        )
//        flexViewConfigurator.applyFlex(flex, to: label)
//        flexViewConfigurator.applyYogaLayout(to: label, preservingOrigin: true)
        
        return label
    }
    
}
