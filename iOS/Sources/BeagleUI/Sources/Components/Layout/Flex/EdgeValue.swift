/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

// MARK: - EdgeValue
public class EdgeValue: Decodable {
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
