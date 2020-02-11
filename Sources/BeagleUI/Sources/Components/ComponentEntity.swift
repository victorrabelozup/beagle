//
//  Copyright © 2019 Zup IT. All rights reserved.
//

public protocol ComponentEntity: Decodable {}

public typealias ComponentConvertibleEntity = ComponentEntity & ComponentConvertible
