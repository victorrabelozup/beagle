//
//  Copyright © 09/10/19 Zup IT. All rights reserved.
//

import UIKit

public class BeagleScreenViewController: UIViewController {
    
    // MARK: - Dependencies
    
    public let viewModel: BeagleScreenViewModel
    
    // MARK: - Properties

    private(set) var rootWidgetView: UIView = {
        let root = UIView()
        root.backgroundColor = .clear
        root.translatesAutoresizingMaskIntoConstraints = false
        return root
    }()

    private lazy var keyboardConstraint: NSLayoutConstraint = {
        view.bottomAnchor.constraint(greaterThanOrEqualTo: rootWidgetView.bottomAnchor)
    }()

    private var keyboardManager: KeyboardManager?

    var dependencies: ViewModel.Dependencies {
        return viewModel.dependencies
    }
    
    // MARK: - Initialization

    public init(
        viewModel: BeagleScreenViewModel
    ) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        initView()
        viewModel.stateObserver = self
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    private func initView() {
        // TODO: uncomment this when using Xcode > 10.3 (which will support iOS 13)
        // if #available(iOS 13.0, *) {
        //    view.backgroundColor = UIColor.systemBackground
        // } else {
            view.backgroundColor = .white
        // }
        view.addSubview(rootWidgetView)
        addConstraints()
    }

    func updateView(state: ViewModel.State) {
        switch state {
        case .loading:
            view.showLoading(.whiteLarge)

        case .result(let result):
            view.hideLoading()
            if case .success(let widget) = result {
                buildViewFromWidget(widget)
            }
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
        keyboardManager = KeyboardManager(
            bottomConstraint: keyboardConstraint,
            view: view
        )
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        keyboardManager = nil
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let widgetView = rootWidgetView.subviews.first else { return }

        widgetView.frame = rootWidgetView.bounds
        dependencies.flex.applyYogaLayout(to: widgetView, preservingOrigin: true)
    }
    
    // MARK: - View Setup

    private func addConstraints() {
        let root = rootWidgetView
        let bottomConstraint: NSLayoutConstraint
        var constraints: [NSLayoutConstraint]

        if #available(iOS 11.0, *) {
            let guide = view.safeAreaLayoutGuide
            bottomConstraint = root.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
            constraints = [
                root.topAnchor.constraint(equalTo: guide.topAnchor),
                root.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
                root.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                bottomConstraint
            ]
        } else {
            bottomConstraint = root.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
            constraints = [
                root.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                root.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                root.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomConstraint
            ]
        }

        bottomConstraint.priority = .init(999)

        constraints.append(keyboardConstraint)
        NSLayoutConstraint.activate(constraints)
    }

    private func buildViewFromWidget(_ widget: Widget) {
        let view = widget.toView(context: self, dependencies: viewModel.dependencies)
        setupWidgetView(view)
    }
    
    private func setupWidgetView(_ widgetView: UIView) {
        rootWidgetView.addSubview(widgetView)
        widgetView.frame = rootWidgetView.bounds
        dependencies.flex.applyYogaLayout(to: widgetView, preservingOrigin: true)
    }
}

// MARK: - Observer

extension BeagleScreenViewController: BeagleScreenStateObserver {

    public func didChangeState(_ state: ViewModel.State) {
        updateView(state: state)
    }
}
