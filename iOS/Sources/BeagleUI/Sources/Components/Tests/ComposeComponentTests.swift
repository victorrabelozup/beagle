/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
import BeagleUI

final class ComposeComponentTests: XCTestCase { 

    private let imageSize = CGSize(width: 300, height: 200)

    func testComposeComponent() throws {
        let component = ComposeText(title: "TITLE", subtitle: "subtitle")

        let vc = Beagle.screen(.declarative(component.toScreen()))

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
