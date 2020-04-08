/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation
import UIKit

class ScreenDeepLink: UIViewController, DeeplinkScreen {
    
    required init(path: String, data: [String : String]?) {
           super.init(nibName: nil, bundle: nil)
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       func screenController() -> UIViewController {
           return ScreenDeepLink(path: "", data:  nil)
       }
    
    override func loadView() {
        super.loadView()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.topItem?.title = "Screen DeepLink"
    }
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.text = "Screen DeepLink"
        label.font = UIFont(name: "Avenir Next", size: 31)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension ScreenDeepLink: ViewLayoutHelper {
    func buildViewHierarchy() {
        view.addSubview(label)
    }
    
    func setupContraints() {
        label.anchorCenterSuperview()
    }
    
    func setupAdditionalConfiguration() {
        navigationController?.navigationBar.barTintColor = .lightGray
        self.view.backgroundColor = .white
    }
    
    
}
