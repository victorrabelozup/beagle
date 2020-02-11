//
//  Copyright © 08/11/19 Zup IT. All rights reserved.
//

/// Action to represent a screen transition
public enum Navigate: Action {
    
    var newPath: NewPath? {
        switch self {
        case .addView(let data), .swapView(let data), .presentView(let data):
            return NewPath(path: data.path, shouldPrefetch: data.shouldPrefetch)

        case .finishView, .popView, .popToView, .openDeepLink:
            return nil
        }
    }
    
    case openDeepLink(DeepLinkNavigation)
    
    case swapView(NewPath)
    case addView(NewPath)
    case presentView(NewPath)

    case finishView
    case popView
    case popToView(Path)

    public typealias Path = String
    public typealias Data = [String: String]

    public struct NewPath {
        public let path: Path
        public let shouldPrefetch: Bool
        
        public init(path: Path, shouldPrefetch: Bool = false) {
            self.path = path
            self.shouldPrefetch = shouldPrefetch
        }
    }
    
    public struct DeepLinkNavigation {
        public let path: Path
        public let data: Data?

        public init(path: Path, data: Data? = nil) {
            self.path = path
            self.data = data
        }
    }
}
