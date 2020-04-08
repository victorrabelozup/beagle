/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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

extension DSCollection: Renderable {
    func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let view = DSCollectionUIComponent(dataSource: dataSource)
        view.flex.setup(flex)
        return view
    }
}
