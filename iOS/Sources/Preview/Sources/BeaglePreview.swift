/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

import BeagleUI

public class BeaglePreview {

    // MARK: Static

    public static func present(in viewController: UIViewController) {
        self.shared.present(in: viewController)
    }

    deinit {
        self.viewController = nil
        self.connection.disconnect()
    }

    // MARK: Private

    private static let shared = BeaglePreview()

    private var connection = ConnectionHandler()
    private var viewController: BeaglePreviewViewController?

    private init() {
        self.connection.delegate = self
    }

    private func present(in presentingViewController: UIViewController) {

        let viewController = BeaglePreviewViewController()
        viewController.modalPresentationStyle = .fullScreen
        presentingViewController.present(viewController, animated: true, completion: { [weak self] in
            guard let self = self else { return }
            self.connection.connect()
        })

        self.viewController = viewController
    }

}

extension BeaglePreview: ConnectionHandlerDelegate {

    func onLayoutChange(_ json: String) {
        viewController?.reloadScreen(with: json)
    }
}
