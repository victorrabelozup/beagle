//
//  Copyright © 04/12/19 Zup IT. All rights reserved.
//

import Foundation
import UIKit    

public class PageIndicator: PageIndicatorComponent {

    public var selectedColor: String?
    public var unselectedColor: String?

    public init(
        selectedColor: String? = nil,
        unselectedColor: String? = nil
        
    ) {
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        
    }
    
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let view = PageIndicatorUIComponent(selectedColor: selectedColor, unselectedColor: unselectedColor)
        return view
    }
}

class PageIndicatorUIComponent: UIView, PageIndicatorUIView {
    
    weak var outputReceiver: PageIndicatorOutput?
    
    typealias Model = PageIndicatorUIViewModel
    
    private let selectedColor: UIColor
    private let unselectedColor: UIColor
    
    var model: Model? { didSet {
        guard let model = model else { return }
        updateView(model: model)
        }}
    
    private lazy var pageControl: UIPageControl = {
        let indicator = UIPageControl()
        indicator.currentPageIndicatorTintColor = selectedColor
        indicator.pageIndicatorTintColor = unselectedColor
        indicator.currentPage = 0
        return indicator
    }()
    
    // MARK: - Init
    
    required init(selectedColor: String? = nil, unselectedColor: String? = nil) {
        if let selected = selectedColor, !selected.isEmpty {
            self.selectedColor = UIColor(hex: selected)
        } else {
            self.selectedColor = UIColor(hex: "#808080")
        }
        
        if let unselected = unselectedColor, !unselected.isEmpty {
            self.unselectedColor = UIColor(hex: unselected)
        } else {
            self.unselectedColor = UIColor(hex: "#d3d3d3")
        }
        
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
