//
//  Copyright © 08/11/19 Zup IT. All rights reserved.
//

/// Action to represent a screen transition
public enum Navigate: Action {

    case openDeepLink(DeepLink)

    case swapView(Path)
    case addView(Path)
    case presentView(Path)

    case finishView
    case popView
    case popToView(Path)

    public typealias Path = String
    public typealias Data = [String: String]

    public struct DeepLink {
        public let path: Path
        public let data: Data?

        public init(path: Path, data: Data? = nil) {
            self.path = path
            self.data = data
        }
    }
}
