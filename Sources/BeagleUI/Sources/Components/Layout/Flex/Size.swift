//
//  Copyright © 06/03/20 Zup IT. All rights reserved.
//

// MARK: - Flex Size

public class Size: Decodable {
    // MARK: - Public Properties
    public var width: UnitValue?
    public var height: UnitValue?
    public var maxWidth: UnitValue?
    public var maxHeight: UnitValue?
    public var minWidth: UnitValue?
    public var minHeight: UnitValue?
    public var aspectRatio: Double?
    
    public init(
        width: UnitValue? = nil,
        height: UnitValue? = nil,
        maxWidth: UnitValue? = nil,
        maxHeight: UnitValue? = nil,
        minWidth: UnitValue? = nil,
        minHeight: UnitValue? = nil,
        aspectRatio: Double? = nil
    ) {
        self.width = width
        self.height = height
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.minWidth = minWidth
        self.minHeight = minHeight
        self.aspectRatio = aspectRatio
    }
}

extension Flex {
    public static func height() -> Size {
        return Size()
    }
}
