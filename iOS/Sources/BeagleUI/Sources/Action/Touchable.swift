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

public struct Touchable: ServerDrivenComponent {
    
    // MARK: - Public Properties
    
    public let action: Action
    public let child: ServerDrivenComponent
    
    // MARK: - Initialization
    
    public init(
        action: Action,
        child: ServerDrivenComponent
    ) {
        self.action = action
        self.child = child
    }
}

extension Touchable: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        context.register(action: action, inView: childView)
        prefetchComponent(context: context, dependencies: dependencies)
        return childView
    }
    
    private func prefetchComponent(context: BeagleContext, dependencies: RenderableDependencies) {
        guard let newPath = (action as? Navigate)?.newPath else { return }
        dependencies.preFetchHelper.prefetchComponent(newPath: newPath, dependencies: dependencies)
    }
}

extension Touchable: Decodable {
    enum CodingKeys: String, CodingKey {
        case action
        case child
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.action = try container.decode(forKey: .action)
        self.child = try container.decode(forKey: .child)
    }
}
