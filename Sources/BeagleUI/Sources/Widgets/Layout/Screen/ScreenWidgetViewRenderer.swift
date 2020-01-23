//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class ScreenWidgetViewRenderer: ViewRendering<ScreenWidget> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        guard let beagleController = context as? BeagleScreenViewController,
            beagleController.screenController.navigationController == nil else {
                return createWidgetContentView(context: context)
        }
        
        let contentController = BeagleScreenViewController(
            viewModel: .init(
                screenType: .declarative(widget),
                dependencies: beagleController.viewModel.dependencies,
                delegate: beagleController.viewModel.delegate
            )
        )
        let navigationController = UINavigationController(rootViewController: contentController)
        
        beagleController.addChildViewController(navigationController)
        DispatchQueue.main.async {
            navigationController.didMove(toParentViewController: beagleController)
        }
        return navigationController.view
    }

    // MARK: - Private Functions
    
    private func createWidgetContentView(context: BeagleContext) -> UIView {
        let header = buildChildWidget(widget.header, context: context)
        let content = buildChildWidget(widget.content, context: context)
        let footer = buildChildWidget(widget.footer, context: context)
        
        if header == nil && footer == nil, let content = content {
            return content
        }
        
        let container = UIView()
        
        if let header = header {
            container.addSubview(header)
            dependencies.flex.enableYoga(true, for: header)
        }
        
        if let content = content {
            container.addSubview(content)
            dependencies.flex.setupFlex(Flex(grow: 1), for: content)
        }
        
        if let footer = footer {
            container.addSubview(footer)
            dependencies.flex.enableYoga(true, for: footer)
        }
        
        return container
    }
    
    private func buildChildWidget(_ widget: Widget?, context: BeagleContext) -> UIView? {
        guard let widget = widget else {
            return nil
        }
        return dependencies.rendererProvider
            .buildRenderer(for: widget, dependencies: dependencies)
            .buildView(context: context)
    }

}
