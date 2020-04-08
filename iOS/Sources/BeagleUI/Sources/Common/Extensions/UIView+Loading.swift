/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */


import UIKit

extension UIView {

    /// Shows a loading view on top of some View
    func showLoading(_ activityIndicatorStyle: UIActivityIndicatorView.Style = .gray) {
        viewWithTag(LoadingView.tag)?.removeFromSuperview() // ensure that we have no other loadingView here
        let loadingView = LoadingView(frame: frame)
        loadingView.activityIndicatorStyle = activityIndicatorStyle
        addSubview(loadingView)
        loadingView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        loadingView.startAnimating()
    }
    
    /// Tries to hide the loadingView that is visible
    func hideLoading(completion: (() -> Void)? = nil) {
        let loadingView = viewWithTag(LoadingView.tag)
        // swiftlint:disable multiline_arguments
        UIView.animate(withDuration: 0.25, animations: {
            loadingView?.alpha = 0
        }, completion: { _ in
            (loadingView as? LoadingView)?.stopAnimating()
            loadingView?.removeFromSuperview()
            completion?()
        })
    }

}
