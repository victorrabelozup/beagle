//
//  Copyright © 06/03/20 Zup IT. All rights reserved.
//

// MARK: - EdgeValue
public class EdgeValue {
    // MARK: - Public Properties
    public var left: UnitValue?
    public var top: UnitValue?
    public var right: UnitValue?
    public var bottom: UnitValue?
    public var start: UnitValue?
    public var end: UnitValue?
    public var horizontal: UnitValue?
    public var vertical: UnitValue?
    public var all: UnitValue?
    
    public init(
        left: UnitValue? = nil,
        top: UnitValue? = nil,
        right: UnitValue? = nil,
        bottom: UnitValue? = nil,
        start: UnitValue? = nil,
        end: UnitValue? = nil,
        horizontal: UnitValue? = nil,
        vertical: UnitValue? = nil,
        all: UnitValue? = nil
    ) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
        self.start = start
        self.end = end
        self.horizontal = horizontal
        self.vertical = vertical
        self.all = all
    }
}

