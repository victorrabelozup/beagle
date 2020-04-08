/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation
import UIKit

public struct PageIndicatorUIViewModel {
    public let numberOfPages: Int
    public let currentPage: Int
}

public protocol PageIndicatorUIView: AnyObject {
    var outputReceiver: PageIndicatorOutput? { get set }
    var model: PageIndicatorUIViewModel? { get set }
}

public protocol PageIndicatorOutput: AnyObject {
    func swipeToPage(at index: Int)
}
