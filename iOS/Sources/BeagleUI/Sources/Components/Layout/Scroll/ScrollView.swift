//
// Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit

public struct ScrollView: AppearanceComponent {
    
    // MARK: - Public Properties
    
    public let children: [ServerDrivenComponent]
    public let appearance: Appearance?
    
    // MARK: - Initialization

    public init(
        children: [ServerDrivenComponent],
        appearance: Appearance? = nil
    ) {
        self.children = children
        self.appearance = appearance
    }
    
}

extension ScrollView: Decodable {
    enum CodingKeys: String, CodingKey {
        case children
        case appearance
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.children = try container.decode(forKey: .children)
        self.appearance = try container.decodeIfPresent(Appearance.self, forKey: .appearance)
    }
}

extension ScrollView: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let scrollView = BeagleContainerScrollView()
        let contentView = UIView()
        
        children.forEach {
            let childView = $0.toView(context: context, dependencies: dependencies)
            contentView.addSubview(childView)
            childView.flex.isEnabled = true
        }
        scrollView.addSubview(contentView)
        scrollView.beagle.setup(appearance: appearance)
        scrollView.flex.setup(Flex(grow: 1))
        
        let flexContent = Flex(grow: 0, shrink: 0)
        contentView.flex.setup(flexContent)
        
        return scrollView
    }
}

final class BeagleContainerScrollView: UIScrollView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if let contentView = subviews.first {
            contentSize = contentView.frame.size
        }
    }
}
