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
    let data: [String: String]?
}

extension NavigateEntity: UIModelConvertible {

    struct Error: Swift.Error {
        let reason: String
    }

    func mapToUIModel() throws -> Navigate {
        switch type {
        case .openDeepLink:
            let path = try usePath()
            return .openDeepLink(
                .init(path: path, data: data)
            )

        case .swapView:
            let path = try usePath()
            return .swapView(path)

        case .addView:
            let path = try usePath()
            return .addView(path)

        case .finishView:
            return .finishView
        case .popView:
            return .popView

        case .popToView:
            let path = try usePath()
            return .popToView(path)

        case .presentView:
            let path = try usePath()
            return .presentView(path)
        }
    }

    private func usePath() throws -> String {
        guard let path = self.path else {
            throw Error(reason: "Error: Navigate of `type` \(type), should have property `path`")
        }
        return path
    }
}

extension NavigateEntity: ActionConvertibleEntity {
    func mapToAction() throws -> Action {
        return try mapToUIModel()
    }
}
