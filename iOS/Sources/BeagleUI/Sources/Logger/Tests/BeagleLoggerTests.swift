/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation
import XCTest
@testable import BeagleUI
import SnapshotTesting

class BeagleLoggerTests: XCTestCase {
    // swiftlint:disable force_unwrapping

    func testLogs() {
        // Given
        let form = Form(action: ActionDummy(), child: ComponentDummy())
        let path = "path"

        let logs: [Log] = [
            Log.network(.couldNotBuildUrl(url: "asdfa/asdfa/asdf")),
            Log.network(.httpRequest(request: .init(url: URLRequest(url: URL(string: "test")!)))),
            Log.network(.httpResponse(response: .init(data: nil, reponse: nil))),

            Log.form(.divergentInputViewAndValueCount(form: form)),
            Log.form(.inputsNotFound(form: form)),
            Log.form(.submitNotFound(form: form)),
            Log.form(.submittedValues(values: ["key1": "value1"])),
            Log.form(.validationInputNotValid(inputName: "inputName")),
            Log.form(.validatorNotFound(named: "validatorName")),

            Log.navigation(.cantPopToAlreadyCurrentScreen(identifier: "identifier")),
            Log.navigation(.didReceiveAction(Navigate.addView(.init(path: path)))),
            Log.navigation(.didReceiveAction(Navigate.openDeepLink(.init(path: path)))),
            Log.navigation(.didReceiveAction(Navigate.openDeepLink(.init(path: path, data: ["key": "value"], component: Text("bla"))))),
            Log.navigation(.errorTryingToPopScreenOnNavigatorWithJustOneScreen),
            Log.navigation(.didNotFindDeepLinkScreen(path: path)),

            Log.decode(.decodingError(type: "error"))
        ]

        // When
        let messages = logs.map { $0.message }

        // Then
        let result = messages.joined(separator: "\n\n")
        assertSnapshot(matching: result, as: .description)
    }
}

class BeagleLoggerDumb: BeagleLoggerType {
    func log(_ log: LogType) {
        return
    }
}
