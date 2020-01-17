//
//  CustomPageIndicator.swift
//  BeagleFrameworkTests
//
//  Created by Yan Dias on 29/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
@testable import BeagleUI

// MARK: - CustomPageIndicator Widget

public struct CustomPageIndicator: PageIndicator {
    // MARK: - Public Properties

    public let selectedColor: String
    public let defaultColor: String

    // MARK: Initialization

    public init(
        selectedColor: String,
        defaultColor: String
    ) {
        self.selectedColor = selectedColor
        self.defaultColor = defaultColor
    }
}

// MARK: - CustomPageIndicator Entity

public struct CustomPageIndicatorEntity: WidgetConvertibleEntity {
    let selectedColor: String
    let defaultColor: String

    public func mapToWidget() throws -> Widget {
        return CustomPageIndicator(selectedColor: selectedColor, defaultColor: defaultColor)
    }
}

// MARK: - CustomPageIndicator Renderer

public final class CustomPageIndicatorRenderer: ViewRendering<CustomPageIndicator> {
    public override func buildView(context: BeagleContext) -> UIView {
        return CustomPageIndicatorUIComponent()
    }
}

// MARK: - CustomPageIndicator UIComponent

class CustomPageIndicatorUIComponent: UIView, PageIndicatorUIView {
    
    typealias Model = PageIndicatorUIViewModel

    weak var outputReceiver: PageIndicatorOutput?
    
    var model: Model? { didSet {
        guard let model = model else { return }
        updateView(model: model)
    }}

    private lazy var pageControl: UIPageControl = {
        let indicator = UIPageControl()
        indicator.currentPage = 0
        indicator.pageIndicatorTintColor = .green
        indicator.currentPageIndicatorTintColor = .red
        indicator.backgroundColor = .blue
        return indicator
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("left", for: .normal)
        button.backgroundColor = .red
        return button
    }()

    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("right", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    // MARK: - Init

    required init() {
        super.init(frame: .zero)
        setupLayout()
        setbuttonActions()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        BeagleUI.fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private functions
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(rightButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.anchor(
            top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor
        )
    }

    private func setbuttonActions() {
        leftButton.addTarget(self, action: #selector(leftButtonTouch), for: .touchDown)
        rightButton.addTarget(self, action: #selector(rightButtonTouch), for: .touchDown)
    }
    
    @objc private func leftButtonTouch() {
        guard let model = model else { return }
        outputReceiver?.swipeToPage(at: model.currentPage - 1)
    }
    
    @objc private func rightButtonTouch() {
        guard let model = model else { return }
        outputReceiver?.swipeToPage(at: model.currentPage + 1)
    }
    
    // MARK: Update
    
    private func updateView(model: Model) {
        pageControl.currentPage = model.currentPage
        pageControl.numberOfPages = model.numberOfPages
    }
}
