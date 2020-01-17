//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

public struct ScrollView: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let children: [Widget]
    public let appearance: Appearance?
    
    // MARK: - Initialization

    public init(
        children: [Widget],
        appearance: Appearance? = nil
    ) {
        self.children = children
        self.appearance = appearance
    }
    
}
