//
//  Copyright © 17/02/20 Zup IT. All rights reserved.
//

import XCTest
import BeagleUI

final class ComposeComponentTests: XCTestCase {

    private let imageSize = CGSize(width: 300, height: 200)

    func testComposeComponent() throws {
        let component = ComposeText(title: "TITLE", subtitle: "subtitle")

        let vc = BeagleScreenViewController(viewModel: .init(screenType: .declarative(component.toScreen())))

        assertSnapshotImage(vc, size: imageSize)
    }
}

struct ComposeText: ComposeComponent {
    var title: String = ""
    var subtitle: String = ""
    
    func build() -> ServerDrivenComponent {
        return Container(children: [
            Text(title),
            Text(subtitle)
        ], flex: Flex())
    }
}
