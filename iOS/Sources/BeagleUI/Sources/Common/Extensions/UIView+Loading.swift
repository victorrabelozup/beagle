//
//  UIView+Loading.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

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
