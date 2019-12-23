//
//  TabViewScreen.swift
//  BeagleDemo
//
//  Created by Gabriela Coelho on 17/12/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import BeagleUI


struct TabViewScreen {
    var content: Widget {
        TabView(tabItems: [
            TabItem(icon: "beagle", content: {
                FlexWidget {
                    Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
                    NetworkImage(url: "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/47/b9/9b/47b99ba2-8b0e-9b08-96f6-70cc8a22d773/source/256x256bb.jpg")
                    Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")

                }.applyFlex(Flex(alignContent: .center))
            }),
            TabItem(title: "Tab com titulo 2", content: {
                FlexWidget {
                    Text("Text1 Tab 2")
                    Text("Text2 Tab 2")
                }.applyFlex(Flex(justifyContent: .center, alignItems: .center))
            }),
            TabItem(title: "Tab 3", content: {
                FlexWidget {
                    Text("Text1 Tab 3")
                    Text("Text2 Tab 3")
                }.applyFlex(Flex(justifyContent: .flexStart))
            }),
            TabItem(icon: "beagle", title: "Tab 4", content: {
                FlexWidget {
                    Text("Text1 Tab 4")
                    Text("Text2 Tab 4")
                }.applyFlex(Flex(alignItems: .center))
            })
        ]
    )}
}

