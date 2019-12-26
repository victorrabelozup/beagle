//
//  NetworkUIImageView.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class NetworkUIImageView: UIImageView, HTTPRequestCanceling {
    
    private let imageDataProvider: ImageDataProvider
    private let url: String
    private var urlRequestToken: URLRequestToken?
    
    init(
        frame: CGRect = .zero,
        imageDataProvider: ImageDataProvider,
        url: String
    ) {
        self.imageDataProvider = imageDataProvider
        self.url = url
        super.init(frame: frame)
        fetchImageData()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cancelHTTPRequest() {
        urlRequestToken?.cancel()
    }
    
    // MARK: - Private function
    private func fetchImageData() {
        urlRequestToken = imageDataProvider.fetchImageData(from: url) { result in
            guard let imageData = try? result.get() else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
