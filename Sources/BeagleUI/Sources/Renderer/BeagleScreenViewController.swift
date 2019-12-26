//
//  BeagleScreenViewController.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 09/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

extension BeagleScreenViewController {
    public enum ScreenType {
        case remote(String)
        case declarative(Widget)
    }
}

public protocol BeagleScreenViewControllerDelegate: AnyObject {

    func beagleScreenViewController(
        _ controller: BeagleScreenViewController,
        didFailToLoadWithError error: Error
    )
}

public class BeagleScreenViewController: UIViewController {
    
    // MARK: - Dependencies
    
    let screenType: ScreenType
    var dependencies: Dependencies

    public typealias Dependencies =
        DependencyActionExecutor
        & DependencyRemoteConnector
        & ViewRenderer.Dependencies
    
    // MARK: - Properties
    
    weak open var delegate: BeagleScreenViewControllerDelegate?
    
    weak var rootWidgetView: UIView?
    var keyboardConstraint: NSLayoutConstraint?
    
    // MARK: - Initialization

    public init(
        screenType: ScreenType,
        dependencies: Dependencies = Beagle.dependencies,
        delegate: BeagleScreenViewControllerDelegate? = nil
    ) {
        self.screenType = screenType
        self.dependencies = dependencies
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        setupView()
        loadScreen()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardChangeNotification(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHideNotification(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
        
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardChangeNotification(_ notification: Notification) {
        let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        configureKeybord(height: height ?? 0, notification: notification)
    }
    
    @objc private func handleKeyboardWillHideNotification(_ notification: Notification) {
        configureKeybord(height: 0, notification: notification)
    }
    
    private func configureKeybord(height: CGFloat, notification: Notification) {
        let curve = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        let options = UIView.AnimationOptions(rawValue: (curve ?? 0) << 16)
        UIView.animate(
            withDuration: duration ?? 0,
            delay: 0,
            options: options,
            animations: {
                self.keyboardConstraint?.constant = height
                self.view.layoutIfNeeded()
            },
            completion: nil
        )
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let widgetView = rootWidgetView?.subviews.first {
            widgetView.frame = (rootWidgetView ?? view).bounds
            dependencies.flex.applyYogaLayout(to: widgetView, preservingOrigin: true)
        }
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = .white
        }
        let rootView = UIView()
        rootView.backgroundColor = .clear
        rootView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rootView)
        
        let keyboardConstraint = view.bottomAnchor.constraint(greaterThanOrEqualTo: rootView.bottomAnchor)
        let bottomConstraint: NSLayoutConstraint
        let constraints: [NSLayoutConstraint]
        if #available(iOS 11.0, *) {
            let guide = view.safeAreaLayoutGuide
            bottomConstraint = rootView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
            constraints = [
                rootView.topAnchor.constraint(equalTo: guide.topAnchor),
                rootView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
                rootView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                bottomConstraint, keyboardConstraint
            ]
        } else {
            bottomConstraint = rootView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
            constraints = [
                rootView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomConstraint, keyboardConstraint
            ]
        }
        bottomConstraint.priority = .init(999)
        NSLayoutConstraint.activate(constraints)
        
        self.keyboardConstraint = keyboardConstraint
        self.rootWidgetView = rootView
    }
    
    private func loadScreen() {
        switch screenType {
        case let .declarative(widget):
            loadDeclarativeScreenWithRootWidget(widget, context: self)
        case let .remote(url):
            loadScreenFromURL(url)
        }
    }
    
    // MARK: - Declarative Screen Loading
    
    private func loadDeclarativeScreenWithRootWidget(_ widget: Widget, context: BeagleContext) {
        let view = widget.toView(context: context, dependencies: dependencies)
        setupWidgetView(view)
    }
    
    // MARK: - Remote Screen Loading
    
    private func loadScreenFromURL(_ url: String) {
        view.showLoading(.whiteLarge)
        self.dependencies.remoteConnector.fetchWidget(from: url) { [weak self] result in
            self?.view.hideLoading()
            switch result {
            case let .success(widget):
                self?.buildViewFromWidget(widget)
            case let .failure(error):
                self?.handleError(error)
            }
        }
    }
    
    // MARK: - View Setup

    private func buildViewFromWidget(_ widget: Widget) {
        let view = widget.toView(context: self, dependencies: dependencies)
        setupWidgetView(view)
    }
    
    private func setupWidgetView(_ widgetView: UIView) {
        rootWidgetView?.addSubview(widgetView)
        widgetView.frame = (rootWidgetView ?? view).bounds
        dependencies.flex.applyYogaLayout(to: widgetView, preservingOrigin: true)
    }
    
    // MARK: - Error Handling
    
    func handleError(_ error: Error) {
        delegate?.beagleScreenViewController(self, didFailToLoadWithError: error)
    }
    
}
