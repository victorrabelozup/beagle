//
//  Copyright © 09/10/19 Zup IT. All rights reserved.
//

import UIKit

public class BeagleScreenViewController: UIViewController {
    
    public let viewModel: BeagleScreenViewModel
    private var viewIsPresented = false
    
    private(set) var rootComponentView: UIView = {
        let root = UIView()
        root.backgroundColor = .clear
        root.translatesAutoresizingMaskIntoConstraints = false
        return root
    }()
    
    private lazy var keyboardConstraint: NSLayoutConstraint = {
        view.bottomAnchor.constraint(greaterThanOrEqualTo: rootComponentView.bottomAnchor)
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
        renderComponentIfNeeded()
        super.viewWillAppear(animated)
        
        updateNavigationBar(animated: animated)

// TODO: remove this comment when #184 gets fixed
//        keyboardManager = KeyboardManager(
//            bottomConstraint: keyboardConstraint,
//            view: view
//        )
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewIsPresented = false
    }
    
    private func renderComponentIfNeeded() {
        guard viewIsPresented, let screen = viewModel.screen else { return }
        switch viewModel.state {
        case .success, .failure:
            renderScreen(screen)
        case .loading, .rendered:
            break
        }
    }
    
    private func renderScreen(_ screen: Screen) {
        buildViewFromScreen(screen)
        safeAreaManager?.safeArea = screen.safeArea
        viewModel.didRenderComponent()
    }
    
    private func updateNavigationBar(animated: Bool) {
        let screenNavigationBar = viewModel.screen?.navigationBar
        let hideNavBar = screenNavigationBar == nil
        navigationController?.setNavigationBarHidden(hideNavBar, animated: animated)
        navigationItem.title = viewModel.screen?.navigationBar?.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.hidesBackButton = !(viewModel.screen?.navigationBar?.showBackButton ?? true)
        
        navigationItem.rightBarButtonItems = screenNavigationBar?.navigationBarItems?.reversed().map {
            $0.toBarButtonItem(context: self, dependencies: viewModel.dependencies)
        }
        
        if let style = viewModel.screen?.navigationBar?.style,
            let navigationBar = navigationController?.navigationBar {
            viewModel.dependencies.theme.applyStyle(for: navigationBar, withId: style)
        }
        
        guard let isTranslucent = navigationController?.navigationBar.isTranslucent
            else { return }
        extendedLayoutIncludesOpaqueBars = isTranslucent ? false : true
    }
    
    // MARK: -
    
    fileprivate func updateView(state: ViewModel.State) {
        switch state {
        case .loading:
            view.showLoading(.whiteLarge)
        case .success, .failure:
            view.hideLoading()
            renderComponentIfNeeded()
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
        
        guard let componentView = rootComponentView.subviews.first else { return }
        
        componentView.frame = rootComponentView.bounds
        componentView.flex.applyLayout()
    }
    
    // MARK: - View Setup
    
    private func initView() {
        // TODO: uncomment this when using Xcode > 10.3 (which will support iOS 13)
        // if #available(iOS 13.0, *) {
        //    view.backgroundColor = UIColor.systemBackground
        // } else {
        view.backgroundColor = .white
        // }
        view.addSubview(rootComponentView)
        safeAreaManager = SafeAreaManager(
            viewController: self,
            view: rootComponentView,
            safeArea: viewModel.screen?.safeArea
        )
        keyboardConstraint.isActive = true
    }
    
    private func buildViewFromScreen(_ screen: Screen) {
        let view = screen.toView(context: self, dependencies: viewModel.dependencies)
        setupComponentView(view)
    }
    
    private func setupComponentView(_ componentView: UIView) {
        rootComponentView.addSubview(componentView)
        componentView.frame = rootComponentView.bounds
        componentView.flex.applyLayout()
    }
}

// MARK: - Observer

extension BeagleScreenViewController: BeagleScreenStateObserver {
    
    public func didChangeState(_ state: ViewModel.State) {
        updateView(state: state)
    }
}
