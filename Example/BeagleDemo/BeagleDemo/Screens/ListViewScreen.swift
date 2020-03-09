//
//  Copyright © 2020 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct ListViewScreen: DeeplinkScreen {
    
    init(path: String, data: [String : String]?) {
    }
    
    func screenController() -> UIViewController {
        return Beagle.screen(.declarative(screen))
    }
    
    var screen: Screen {
        return Screen(
            navigationBar: NavigationBar(title: "ListView"),
            content: listView
        )
    }
    
    var listView = ListView(
        rows: [
            Text("0000"),
            Text("0001", flex: Flex(size: Flex.Size(width: .init(value: 100, type: .real), height: .init(value: 100, type: .real)))),
            Text("0002"),
            Text("0003"),
            Text("0004"),
            LazyComponent(
                path: "http://www.mocky.io/v2/5e4e91c02f00001f2016a8f2",
                initialState: Text("Loading LazyComponent...")
            ),
            Text("0005"),
            Text("0006"),
            Text("0007"),
            Text("0008"),
            Text("0009"),
            Text("0010"),
            Text("0011"),
            Text("0012"),
            Text("0013"),
            Image(name: "beagle"),
            Text("0014"),
            Text("0015"),
            Text("0016"),
            NetworkImage(path: "https://www.petlove.com.br/images/breeds/193436/profile/original/beagle-p.jpg?1532538271"),
            Text("0017"),
            Text("0018"),
            Text("0019"),
            Text("0020"),
            Container(children: [Text("Text1"), Text("Text2")], flex: Flex())],
        direction: .horizontal)
}

