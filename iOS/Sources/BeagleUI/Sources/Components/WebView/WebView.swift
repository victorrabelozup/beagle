/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit
import WebKit

public struct WebView: FlexComponent {
    public let url: String
    public let flex: Flex?
    
    public init
    (
        url: String,
        flex: Flex? = nil
    ) {
        self.url = url
        self.flex = flex
    }
}

extension WebView: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let webView = WebViewUIComponent(model: WebViewUIComponent.Model(url: url))
        webView.flex.setup(flex)
        return webView
    }
}

extension WebView: Decodable {
    enum CodingKeys: String, CodingKey {
        case url
        case flex
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        self.flex = try container.decodeIfPresent(Flex.self, forKey: .flex)
    }
}
