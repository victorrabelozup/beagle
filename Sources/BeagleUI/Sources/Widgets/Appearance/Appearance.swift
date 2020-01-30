//
//  Copyright © 30/12/19 Zup IT. All rights reserved.
//

public struct Appearance {
    
    // MARK: - Public Properties
    let backgroundColor: String?
    let cornerRadius: Double?
    
    // MARK: - Initialization
    
    public init(
        backgroundColor: String? = nil,
        cornerRadius: Double? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }
}

public protocol HasAppearance {
    var appearance: Appearance? { get }
}
