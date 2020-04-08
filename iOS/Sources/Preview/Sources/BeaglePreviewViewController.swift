/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

import BeagleUI

class BeaglePreviewViewController: UIViewController {

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewController()
    }

    func reloadScreen(with json: String) {
        self.sceneViewController.reloadScreen(with: .declarativeText(json))
    }

    // MARK: Private

    private var sceneViewController: BeagleScreenViewController!

    private func setupChildViewController() {
        self.sceneViewController = BeagleScreenViewController(viewModel: .init(screenType: .declarativeText("")))
        self.sceneViewController.willMove(toParentViewController: self)
        self.sceneViewController.view.frame = self.view.bounds
        self.view.addSubview(self.sceneViewController.view)
        self.addChildViewController(self.sceneViewController)
        self.sceneViewController.didMove(toParentViewController: self)
    }

}
