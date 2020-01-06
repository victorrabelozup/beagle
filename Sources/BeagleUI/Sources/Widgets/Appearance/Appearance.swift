//
//  Copyright © 30/12/19 Zup IT. All rights reserved.
//

public struct Appearance {
    
    // MARK: - Public Properties
    let backgroundColor: String?
    
    // MARK: - Initialization
    
    public init(
        backgroundColor: String? = nil
    ) {
        self.backgroundColor = backgroundColor
    }
}

public protocol HasAppearance {
    var appearance: Appearance? { get }
}
