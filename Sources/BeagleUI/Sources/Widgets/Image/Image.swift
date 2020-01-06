//
//  Copyright © 2019 Zup IT. All rights reserved.
//

public struct Image: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let name: String
    public let contentMode: ImageContentMode?
    public let appearance: Appearance?
    
    // MARK: - Initialization
    
    public init(
        name: String,
        contentMode: ImageContentMode? = nil,
        appearance: Appearance? = nil
    ) {
        self.name = name
        self.contentMode = contentMode
        self.appearance = appearance
    }
    
}
