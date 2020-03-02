//
//  Copyright © 08/11/19 Zup IT. All rights reserved.
//

/// Action to represent a screen transition
public enum Navigate: Action {
    
    var newPath: NewPath? {
        switch self {
        case .addView(let newPath), .swapView(let newPath), .presentView(let newPath):
            return newPath

        case .swapScreen, .addScreen, .presentScreen, .finishView, .popView, .popToView, .openDeepLink:
            return nil
        }
    }
    
    case openDeepLink(DeepLinkNavigation)
    
    case swapScreen(Screen)
    case swapView(NewPath)
    
    case addScreen(Screen)
    case addView(NewPath)
    
    case presentScreen(Screen)
    case presentView(NewPath)

    case finishView
    case popView
    case popToView(Path)

    public typealias Path = String
    public typealias Data = [String: String]

    public struct NewPath {
        public let path: Path
        public let shouldPrefetch: Bool
        public let fallback: Screen?
        
        public init(path: Path, shouldPrefetch: Bool = false, fallback: Screen? = nil) {
            self.path = path
            self.shouldPrefetch = shouldPrefetch
            self.fallback = fallback
        }
    }
    
    public struct DeepLinkNavigation {

        public let path: Path
        public let data: Data?
        public let component: ServerDrivenComponent?

        public init(path: Path, data: Data? = nil, component: ServerDrivenComponent? = nil) {
            self.path = path
            self.data = data
            self.component = component
        }
    }
}
