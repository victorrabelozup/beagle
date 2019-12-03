//
//  Copyright © 21/11/19 Zup IT. All rights reserved.
//

import Foundation
import UIKit

public struct PageIndicatorUIViewModel {
    public let numberOfPages: Int
    public let currentPage: Int
}

public protocol PageIndicatorUIView: UIView {
    var outputReceiver: PageIndicatorOutput? { get set }
    var model: PageIndicatorUIViewModel? { get set }
}

public protocol PageIndicatorOutput: AnyObject {
    func swipeToPage(at index: Int)
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
