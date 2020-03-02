//
//  Copyright © 04/12/19 Zup IT. All rights reserved.
//

import Foundation
import UIKit

public struct DefaultPageIndicatorEntity: WidgetEntity {
    
    public var id: String?
    public var flex: FlexEntity?
    public var appearance: AppearanceEntity?
    public var accessibility: AccessibilityEntity?

    public func mapToComponent() throws -> ServerDrivenComponent {
        return DefaultPageIndicator(
            flex: try flex?.mapToUIModel(),
            appearance: try appearance?.mapToUIModel(),
            accessibility: try accessibility?.mapToUIModel()
        )
    }
}

public class DefaultPageIndicator: Widget, PageIndicator {
    
    public var id: String?
    public var flex: Flex?
    public var appearance: Appearance?
    public var accessibility: Accessibility?

    public init(
        id: String? = nil,
        flex: Flex? = nil,
        appearance: Appearance? = nil,
        accessibility: Accessibility? = nil
    ) {
        self.id = id
        self.flex = flex
        self.appearance = appearance
        self.accessibility = accessibility
    }

    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let view = DefaultPageIndicatorUIComponent()

        view.flex.setupFlex(flex)
        view.applyAccessibilityIdentifier(id)
        view.applyAppearance(appearance)
        dependencies.accessibility.applyAccessibilityAttributes(accessibility, to: view)
        return view
    }
}

class DefaultPageIndicatorUIComponent: UIView, PageIndicatorUIView {

    weak var outputReceiver: PageIndicatorOutput?

    typealias Model = PageIndicatorUIViewModel

    var model: Model? { didSet {
        guard let model = model else { return }
        updateView(model: model)
    }}

    private lazy var pageControl: UIPageControl = {
        let indicator = UIPageControl()
        indicator.currentPage = 0
        indicator.pageIndicatorTintColor = .gray
        indicator.currentPageIndicatorTintColor = .white
        return indicator
    }()

    // MARK: - Init

    required init() {
        super.init(frame: .zero)

        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.anchor(
            top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Update

    private func updateView(model: Model) {
        pageControl.currentPage = model.currentPage
        pageControl.numberOfPages = model.numberOfPages
    }
}
