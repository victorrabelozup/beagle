//
//  Copyright © 02/12/19 Zup IT. All rights reserved.
//

import Foundation
@testable import BeagleUI

enum ComponentFromJsonError: Error {
    case wrongUrlPath
    case couldNotMatchComponentType
}

func componentFromJsonFile<W: ServerDrivenComponent>(
    fileName: String,
    decoder: ComponentDecoding = ComponentDecoder()
) throws -> W {
    guard let url = Bundle(for: ComponentDecoderTests.self).url(
        forResource: fileName,
        withExtension: ".json"
    ) else {
        throw ComponentFromJsonError.wrongUrlPath
    }

    let json = try Data(contentsOf: url)
    let component = try decoder.decodeComponent(from: json)

    guard let typed = component as? W else {
        throw ComponentFromJsonError.couldNotMatchComponentType
    }

    return typed
}

/// This method was only created due to some problems with Swift Type Inference.
/// So when you pass the type as a parameter, swift can infer the correct type.
func componentFromJsonFile<W: ServerDrivenComponent>(
    componentType: W.Type,
    fileName: String,
    decoder: ComponentDecoding = ComponentDecoder()
) throws -> W {
    return try componentFromJsonFile(fileName: fileName, decoder: decoder)
}
