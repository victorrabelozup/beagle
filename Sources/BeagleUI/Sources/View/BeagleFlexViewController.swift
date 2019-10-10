//
//  BeagleFlexViewController.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 09/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public class BeagleFlexViewController: UIViewController, BeagleFlexViewContaining {
    
    // MARK: - Dependencies
    
    private let flex: Flex
    
    // MARK: - Properties
    
    private var injectedBeagleFlexView: BeagleFlexView?
    
    // MARK: - Initialization
    
    init(flex: Flex) {
        self.flex = flex
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(beagleFlexView: BeagleFlexView) {
        self.init(flex: beagleFlexView.flex)
        self.injectedBeagleFlexView = beagleFlexView
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func loadView() {
        if let injectedView = injectedBeagleFlexView {
            view = injectedView
        } else {
           view = BeagleFlexView(flex: flex)
        }
    }
    
}
