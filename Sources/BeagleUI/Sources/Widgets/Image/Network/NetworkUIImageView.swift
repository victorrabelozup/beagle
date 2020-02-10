//
//  NetworkUIImageView.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class NetworkUIImageView: UIImageView, HTTPRequestCanceling {

    private let network: Network
    private let url: String
    private var token: RequestToken?
    
    init(
        frame: CGRect = .zero,
        network: Network,
        url: String
    ) {
        self.network = network
        self.url = url

        super.init(frame: frame)

        fetchImageData()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cancelHTTPRequest() {
        token?.cancel()
    }
    
    // MARK: - Private function
    private func fetchImageData() {
        token = network.fetchImage(url: url) { [weak self] result in
            guard let self = self else { return }

            guard case .success(let data) = result else { return }

            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
