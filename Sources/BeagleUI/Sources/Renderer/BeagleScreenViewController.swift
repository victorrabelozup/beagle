//
//  Copyright © 09/10/19 Zup IT. All rights reserved.
//

import UIKit

public class BeagleScreenViewController: UIViewController {

    public let viewModel: BeagleScreenViewModel

    private var viewIsPresented = false

    private(set) var rootWidgetView: UIView = {
        let root = UIView()
        root.backgroundColor = .clear
        root.translatesAutoresizingMaskIntoConstraints = false
        return root
    }()

    private lazy var keyboardConstraint: NSLayoutConstraint = {
        view.bottomAnchor.constraint(greaterThanOrEqualTo: rootWidgetView.bottomAnchor)
    }()

    private var safeAreaManager: SafeAreaManager?
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

        viewModel.stateObserver = self
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        viewIsPresented = true
        renderWidgetIfNeeded()

        super.viewWillAppear(animated)

        updateNavigationBar(animated: animated)
        keyboardManager = KeyboardManager(
            bottomConstraint: keyboardConstraint,
            view: view
        )
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewIsPresented = false
    }
    
    private func renderWidgetIfNeeded() {
        guard viewIsPresented, let screen = viewModel.screen, case .success = viewModel.state else { return }
        buildViewFromWidget(screen)
        safeAreaManager?.safeArea = screen.safeArea
        viewModel.didRenderWidget()
    }
    
    private func updateNavigationBar(animated: Bool) {
        let hideNavBar = viewModel.screen?.navigationBar == nil
        navigationController?.setNavigationBarHidden(hideNavBar, animated: animated)
        navigationItem.title = viewModel.screen?.navigationBar?.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.hidesBackButton = !(viewModel.screen?.navigationBar?.showBackButton ?? true)
        
        if let style = viewModel.screen?.navigationBar?.style,
           let navigationBar = navigationController?.navigationBar {
            viewModel.dependencies.theme.applyStyle(for: navigationBar, withId: style)
        }
    }
    
    // MARK: -

    fileprivate func updateView(state: ViewModel.State) {
        switch state {
        case .loading:
            view.showLoading(.whiteLarge)
        case .success, .failure:
            view.hideLoading()
            renderWidgetIfNeeded()
            updateNavigationBar(animated: viewIsPresented)
        case .rendered:
            break
        }
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

    private func initView() {
        // TODO: uncomment this when using Xcode > 10.3 (which will support iOS 13)
        // if #available(iOS 13.0, *) {
        //    view.backgroundColor = UIColor.systemBackground
        // } else {
        view.backgroundColor = .white
        // }
        view.addSubview(rootWidgetView)
        safeAreaManager = SafeAreaManager(
            viewController: self,
            view: rootWidgetView,
            safeArea: viewModel.screen?.safeArea
        )
        keyboardConstraint.isActive = true
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
