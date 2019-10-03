//
//  Screen.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public protocol Screen {
    var content: Container { get }
}

//struct SomeScreen: Screen {
//
//    var content: Container {
//        Container(
//            header: {
//                Stack {
//                    Text("something")
//                    Text("something")
//                }
//            },
//            content: {
//                Vertical {
//                    Text("something")
//                    Text("something")
//                    Text("something")
//                    Text("something")
//                }
//                .reversed()
//            }
//        )
//    }
//
//}
