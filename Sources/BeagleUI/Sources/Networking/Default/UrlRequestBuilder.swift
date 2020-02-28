//
//  Copyright © 05/02/20 Zup IT. All rights reserved.
//

import Foundation

class UrlRequestBuilder {

    func buildUrlRequest(
        request: Request,
        baseUrl: URL?
    ) -> Result<URLRequest, NetworkClientDefault.ClientError> {
        
        guard let url = URL(string: request.url, relativeTo: baseUrl) else {
            return .failure(.invalidUrl)
        }

        var urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 100
        )

        urlRequest.httpMethod = httpMethod(for: request)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        setupParameters(in: &urlRequest, with: request)

        return .success(urlRequest)
    }

    private func httpMethod(for request: Request) -> String {
        switch request.type {
        case .fetchComponent, .fetchImage:
            return "GET"
        case .submitForm(let data):
            return data.method.rawValue
        }
    }

    private func setupParameters(in urlRequest: inout URLRequest, with request: Request) {
        guard case .submitForm(let form) = request.type else { return }

        switch form.method {
        case .post, .put:
            configureBodyParameters(form.values, in: &urlRequest)

        case .get, .delete:
            configureURLParameters(form.values, in: &urlRequest)
        }
    }

    private func configureBodyParameters(
        _ parameters: [String: Any],
        in request: inout URLRequest
    ) {
        if let payload = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = payload
        }
    }

    private func configureURLParameters(
        _ parameters: [String: String],
        in request: inout URLRequest
    ) {
        if
            let url = request.url,
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            request.url = urlComponents.url
        }
    }
}
