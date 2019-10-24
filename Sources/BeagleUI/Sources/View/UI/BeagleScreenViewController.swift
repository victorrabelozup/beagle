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
        case remote(URL)
        case declarative(Screen)
    }
}

public protocol BeagleScreenViewControllerDelegate: AnyObject {
    func beagleScreenViewController(_ controller: BeagleScreenViewController, didFailToLoadWithError error: Error)
}

public class BeagleScreenViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let screenType: ScreenType
    private let mainQueue: Dispatching
    private let viewBuilder: BeagleViewBuilder
    private let serverDrivenScreenLoader: ServerDrivenScreenLoader
    
    // MARK: - Properties
    
    weak var delegate: BeagleScreenViewControllerDelegate?
    
    // MARK: - Initialization
    
    public init(
        screenType: ScreenType,
        mainQueue: Dispatching? = nil,
        viewBuilder: BeagleViewBuilder = BeagleViewBuilding(),
        serverDrivenScreenLoader: ServerDrivenScreenLoader = ServerDrivenScreenLoading()
    ) {
        self.screenType = screenType
        self.mainQueue = mainQueue ?? AsyncQueue.main
        self.viewBuilder = viewBuilder
        self.serverDrivenScreenLoader = serverDrivenScreenLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadScreen()
    }
    
    // MARK: - Private Functions
    
    private func loadScreen() {
        switch screenType {
        case let .declarative(screen):
            loadDeclarativeScreenWithRootWidget(screen.content)
        case let .remote(url):
            loadScreenFromURL(url)
        }
    }
    
    // MARK: - Declarative Screen Loading
    
    private func loadDeclarativeScreenWithRootWidget(_ widget: Widget) {
        let declarativeView = viewBuilder.buildFromRootWidget(widget)
        setupWidgetView(declarativeView)
    }
    
    // MARK: - Remote Screen Loading
    
    private func loadScreenFromURL(_ url: URL) {
        view.showLoading(.whiteLarge)
        serverDrivenScreenLoader.loadScreen(from: url) { [weak self] result in
            self?.view.hideLoading()
            self?.mainQueue.dispatch {
                switch result {
                case let .success(view):
                    self?.setupWidgetView(view)
                case let .failure(error):
                    self?.handleError(error)
                }
            }
        }
    }
    
    // MARK: - View Setup
    
    private func setupWidgetView(_ widgetView: UIView) {
        view.backgroundColor = .white
        view.addSubview(widgetView)
        widgetView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            bottomConstant: 10
        )
    }
    
    // MARK: - Error Handling
    
    private func handleError(_ error: Error) {
        delegate?.beagleScreenViewController(self, didFailToLoadWithError: error)
    }
    
    // TODO: REMOVE THIS BELOW
//    private func setupTestView() {
//
//        let flexConfigurator = FlexViewConfigurator()
//
//        let root = UIView(frame: view.frame)
//        view.addSubview(root)
//        root.backgroundColor = .blue
//        let rootFlex = Flex(
//            direction: .ltr,
//            flexDirection: .row,
//            flexWrap: .noWrap,
//            justifyContent: .flexStart,
//            alignItems: .flexStart,
//            alignSelf: .auto,
//            alignContent: .stretch
//        )
//        flexConfigurator.applyFlex(rootFlex, to: root)
//        flexConfigurator.applyYogaLayout(to: root, preservingOrigin: true)
//
//        let squareOne = UIView(frame: .zero)
//        squareOne.backgroundColor = .red
//        root.addSubview(squareOne)
//        let squareOneFlex = Flex(
//            direction: .ltr,
//            flexDirection: .row,
//            flexWrap: .noWrap,
//            justifyContent: .flexStart,
//            alignItems: .stretch,
//            alignSelf: .flexStart,
//            alignContent: .stretch,
//            shrink: 1.0,
//            size: .init(
//                width: .init(value: 100, type: .real),
//                height: .init(value: 100, type: .real)
//            ),
//            position: .relative
//        )
//        flexConfigurator.applyFlex(squareOneFlex, to: squareOne)
//        flexConfigurator.applyYogaLayout(to: squareOne, preservingOrigin: true)
//
//    }
    
}
