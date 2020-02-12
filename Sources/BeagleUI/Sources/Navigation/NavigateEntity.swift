//
//  Copyright © 08/11/19 Zup IT. All rights reserved.
//

import Foundation

enum NavigationType: String, Decodable, UIEnumModelConvertible, CaseIterable {
    case openDeepLink = "OPEN_DEEP_LINK"
    case swapView = "SWAP_VIEW"
    case addView = "ADD_VIEW"
    case finishView = "FINISH_VIEW"
    case popView = "POP_VIEW"
    case popToView = "POP_TO_VIEW"
    case presentView = "PRESENT_VIEW"
}

struct NavigateEntity: Decodable {
    let type: NavigationType
    let path: String?
    let shouldPrefetch: Bool?
    let screen: ScreenComponentEntity?
    let data: [String: String]?
}

extension NavigateEntity: UIModelConvertible {
    
    private enum Destination {
        case declarative(Screen)
        case remote(Navigate.NewPath)
    }

    struct Error: Swift.Error {
        let reason: String
    }

    func mapToUIModel() throws -> Navigate {
        switch type {
        case .popToView:
            let path = try usePath()
            return .popToView(path)
            
        case .openDeepLink:
            let path = try usePath()
            return .openDeepLink(.init(path: path, data: data))
            
        case .swapView:
            switch try destination() {
            case .declarative(let screen):
                return .swapScreen(screen)
            case .remote(let newPath):
                return .swapView(newPath)
            }
            
        case .addView:
            switch try destination() {
            case .declarative(let screen):
                return .addScreen(screen)
            case .remote(let newPath):
                return .addView(newPath)
            }
            
        case .presentView:
            switch try destination() {
            case .declarative(let screen):
                return .presentScreen(screen)
            case .remote(let newPath):
                return .presentView(newPath)
            }

        case .finishView:
            return .finishView
            
        case .popView:
            return .popView
        }
    }

    private func usePath() throws -> String {
        guard let path = self.path else {
            throw Error(reason: "Error: Navigate of `type` \(type), should have property `path`")
        }
        return path
    }
    
    private func destination() throws -> Destination {
        let screen = try self.screen?.mapToComponent().toScreen()
        if let screen = screen, path == nil {
            return .declarative(screen)
        }
        if let path = self.path {
            return .remote(.init(
                path: path,
                shouldPrefetch: shouldPrefetch ?? false,
                fallback: screen))
        }
        throw Error(reason: "Error: Navigate of `type` \(type), should have property `path` or `screen`")
    }
}

extension NavigateEntity: ActionConvertibleEntity {
    func mapToAction() throws -> Action {
        return try mapToUIModel()
    }
}
