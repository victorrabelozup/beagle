//
//  ViewController.swift
//  BeagleDemo
//
//  Created by Daniel Tes on 10/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit
import BeagleUI
import YogaKit

final class LayoutInclusionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let someScreen = SomeScreen()
        
        
        
    }
    
}

final class FlexConfigurableWidgetRenderer: WidgetViewRenderer {
    
    func render<T: Widget>(_ widget: T) -> UIView {
        switch widget {
        // Core
        case is FlexSingleWidget:
            debugPrint("FlexSingleWidget")
        case is FlexWidget:
            debugPrint("FlexWidget")
        }
    }
    
}

final class WidgetScreenRenderer {
    
    func render(_ widget: Scre) {
        switch widget {
        // Core
        case is FlexSingleWidget:
            debugPrint("FlexSingleWidget")
        case is FlexWidget:
            debugPrint("FlexWidget")
        // Layout
        case is Container:
            debugPrint("Container")
        case is Horizontal:
            debugPrint("Horizontal")
        case is Padding:
            debugPrint("Padding")
        case is Spacer:
            debugPrint("Spacer")
        case is Stack:
            debugPrint("Stack")
        case is Vertical:
            debugPrint("Vertical")
        // UIComponents
        case is Button:
            debugPrint("Button")
        case is DropDown:
            debugPrint("DropDown")
        case is Image:
            debugPrint("Image")
        case is ListView:
            debugPrint("ListView")
        case is SelectView:
            debugPrint("SelectView")
        case is Text:
            debugPrint("Text")
        case is TextField:
            debugPrint("TextField")
        case is ToolBar:
            debugPrint("ToolBar")
        }
    }
}

struct SomeScreen: Screen {

    var content: FlexConfigurableWidget {
        FlexSingleWidget {
            Container(
                header: {
                    Stack {
                        Text("Header Title")
                        Button(text: "Header Button")
                    }
                },
                content: {
                    Vertical {
                        Padding(
                            value: .init(),
                            child: {
                                Container(
                                    content: {
                                        Text("ListView Title")
                                        ListView {
                                            Text("List Item 1")
                                            Text("List Item 2")
                                            Text("List Item 3")
                                            Text("List Item 4")
                                        }
                                    }
                                )
                            }
                        )
                    }
                    .reversed()
                },
                footer: {
                    Stack {
                        Text("Footer Text")
                        Button(text: "Footer Button")
                    }
                }
            )
        }
    }

}


//final class LayoutInclusionViewController: UIViewController {
//
//    private let button: UIButton = UIButton(type: .system)
//    private let disappearingView: UIView = UIView(frame: .zero)
//    private let contentView: UIView = UIView(frame: .zero)
//
//    override func viewDidLoad() {
//        let root = view
//        root?.backgroundColor = .white
//        root?.configureLayout { (layout) in
//            layout.isEnabled = true
//            layout.flexDirection = .column
//            layout.justifyContent = .spaceAround
//        }
//
//        contentView.backgroundColor = .clear
//        contentView.layer.borderColor = UIColor.lightGray.cgColor
//        contentView.layer.borderWidth = 1.0
//        contentView.configureLayout { (layout) in
//            layout.isEnabled = true
//            layout.height = 300
//            layout.width = YGValue(self.view.bounds.size.width)
//            layout.flexDirection = .column
//            layout.justifyContent = .center
//            layout.paddingHorizontal = 25
//        }
//        view.addSubview(contentView)
//
//        let redView = UIView(frame: .zero)
//        redView.backgroundColor = .red
//        redView.configureLayout { (layout) in
//            layout.isEnabled = true
//            layout.flexGrow = 1
//            layout.flexShrink = 1
//        }
//        contentView.addSubview(redView)
//
//        disappearingView.backgroundColor = .blue
//        disappearingView.configureLayout { (layout) in
//            layout.isEnabled = true
//            layout.flexGrow = 1
//        }
//        contentView.addSubview(disappearingView)
//
//        button.setTitle("Add Blue View", for: UIControl.State.selected)
//        button.setTitle("Remove Blue View", for: UIControl.State.normal)
//        button.addTarget(self, action: #selector(buttonWasTapped), for: UIControl.Event.touchUpInside)
//        button.configureLayout { (layout) in
//            layout.isEnabled = true
//            layout.height = 300
//            layout.width = 300
//            layout.alignSelf = .center
//        }
//        root?.addSubview(button)
//
//        root?.yoga.applyLayout(preservingOrigin: false)
//    }
//
//    // MARK - UIButton Action
//    @objc func buttonWasTapped() {
//        button.isSelected = !button.isSelected
//
//        button.isUserInteractionEnabled = false
//        disappearingView.yoga.isIncludedInLayout = !disappearingView.yoga.isIncludedInLayout
//        disappearingView.isHidden = !disappearingView.isHidden
//
//        contentView.yoga.applyLayout(preservingOrigin: true)
//        button.isUserInteractionEnabled = true
//    }
//
//}
