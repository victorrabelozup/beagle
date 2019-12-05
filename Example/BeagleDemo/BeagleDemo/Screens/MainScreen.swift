//
//  MainScreen.swift
//  BeagleDemo
//
//  Created by Lucas Araújo on 03/12/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import BeagleUI

struct MainScreen: DeeplinkScreen {
    init() {}
    init(path: String, data: [String : String]?) {}
    var widget: Widget {
        Container(
            header: {
                NavigationBar(
                    title: "Beagle Demo",
                    leading: { Text("L") },
                    trailing: { Text("T") }
                )
        }, content: {
            FlexWidget {
                Navigator(
                    action: Navigate(
                        type: .addView,
                        path: "https://t001-2751a.firebaseapp.com/flow/step1.json"
                    )
                ) {
                    Button(text: "Navigator")
                }
                Navigator(action: Navigate(type: .openDeepLink, path: "lazywidget")) {
                    Button(text: "Lazy Widget")
                }
                Navigator(action: Navigate(type: .openDeepLink, path: "pageview")) {
                    Button(text: "Page View")
                }
            }
        })
    }
}
