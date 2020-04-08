/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit
import WebKit

final class WebViewUIComponent: UIView {
    
    private var webView = WKWebView()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.color = .gray
        return loadingView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()
    
    struct Model {
        let url: String
    }
    
    private var model: Model?
    
    init(model: Model) {
        self.model = model
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(loadingView)
        stackView.addArrangedSubview(webView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        guard let model = model else { return }
        if let url = URL(string: model.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        loadingView.hidesWhenStopped = true
        webView.navigationDelegate = self
        webView.isHidden = loadingView.isHidden ? true : false
        webView.isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
    }
}

extension WebViewUIComponent: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating()
        webView.isHidden = false
    }
}
