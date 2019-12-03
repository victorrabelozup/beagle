//
//  Copyright © 02/12/19 Zup IT. All rights reserved.
//

import Foundation
@testable import BeagleUI

enum WidgetFromJsonError: Error {
    case wrongUrlPath
    case couldNotMatchWidgetType
}

func widgetFromJsonFile<W: Widget>(
    fileName: String
) throws -> W {
    guard let url = Bundle(for: WidgetDecoderTests.self).url(
        forResource: fileName,
        withExtension: ".json"
    ) else {
        throw WidgetFromJsonError.wrongUrlPath
    }

    let json = try Data(contentsOf: url)
    let widget = try WidgetDecoder().decodeWidget(from: json)

    guard let typed = widget as? W else {
        throw WidgetFromJsonError.couldNotMatchWidgetType
    }

    return typed
}

func widgetFromJsonFile<W: Widget>(
    widgetType: W.Type,
    fileName: String
) throws -> W {
    return try widgetFromJsonFile(fileName: fileName)
}
