/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/// Action to represent a screen transition
public enum Navigate: Action {
    
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

    var newPath: NewPath? {
        switch self {
        case .addView(let newPath), .swapView(let newPath), .presentView(let newPath):
            return newPath

        case .swapScreen, .addScreen, .presentScreen, .finishView, .popView, .popToView, .openDeepLink:
            return nil
        }
    }
}

extension Navigate: CustomStringConvertible {

    public var description: String {
        let name: String
        switch self {
        case .openDeepLink(let link): name = "openDeepLink(\(link))"
        case .swapScreen(let screen): name = "swapScreen(\(screen))"
        case .swapView(let path): name = "swapView(\(path))"
        case .addScreen(let screen): name = "addScreen(\(screen))"
        case .addView(let path): name = "addView(\(path))"
        case .presentScreen(let screen): name = "presentScreen(\(screen))"
        case .presentView(let path): name = "presentView(\(path))"
        case .finishView: name = "finishView"
        case .popView: name = "popView"
        case .popToView(let path): name = "popToView(\(path))"
        }

        return "Navigate.\(name)"
    }
}
