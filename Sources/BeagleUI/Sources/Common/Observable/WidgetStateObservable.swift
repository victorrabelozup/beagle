//
//  Copyright © 28/02/20 Zup IT. All rights reserved.
//

import Foundation

public struct WidgetState {
    public var value: Any?

    public init(value: Any?) {
        self.value = value
    }
}

public protocol WidgetStateObservable {
    var observable: Observable<WidgetState> { get }
}
