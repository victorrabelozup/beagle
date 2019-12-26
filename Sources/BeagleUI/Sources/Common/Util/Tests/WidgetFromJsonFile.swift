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
    fileName: String,
    decoder: WidgetDecoding = WidgetDecoder()
) throws -> W {
    guard let url = Bundle(for: WidgetDecoderTests.self).url(
        forResource: fileName,
        withExtension: ".json"
    ) else {
        throw WidgetFromJsonError.wrongUrlPath
    }

    let json = try Data(contentsOf: url)
    let widget = try decoder.decodeWidget(from: json)

    guard let typed = widget as? W else {
        throw WidgetFromJsonError.couldNotMatchWidgetType
    }

    return typed
}

/// This method was only created due to some problems with Swift Type Inference.
/// So when you pass the type as a parameter, swift can infer the correct type.
func widgetFromJsonFile<W: Widget>(
    widgetType: W.Type,
    fileName: String,
    decoder: WidgetDecoding = WidgetDecoder()
) throws -> W {
    return try widgetFromJsonFile(fileName: fileName, decoder: decoder)
}
