//
//  Copyright © 05/02/20 Zup IT. All rights reserved.
//

import Foundation

class HttpRequestBuilder {

    func build(
        url: URL,
        requestType: Request.RequestType,
        additionalData: HttpAdditionalData?
    ) -> Result {

        var newUrl = url
        var body = additionalData?.httpData?.body

        var headers = ["Content-Type": "application/json"]
        additionalData?.headers.forEach {
            headers.updateValue($0.value, forKey: $0.key)
        }

        setupParametersFor(requestType: requestType, url: &newUrl, body: &body)

        return Result(
            url: newUrl,
            method: httpMethod(type: requestType, data: additionalData),
            headers: headers,
            body: body
        )
    }

    struct Result {
        var url: URL
        var method: String
        var headers: [String: String]
        var body: Data?

        func toUrlRequest() -> URLRequest {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 100)
            request.httpMethod = method
            request.httpBody = body
            headers.forEach {
                request.addValue($0.value, forHTTPHeaderField: $0.key)
            }
            return request
        }
    }

    private func httpMethod(type: Request.RequestType, data: HttpAdditionalData?) -> String {
        switch (type, data) {

        case (.submitForm(let form), _):
            return form.method.rawValue

        case (_, nil):
            return "GET"

        case (_, let data?):
            return data.httpData?.method.rawValue ?? "GET"
        }
    }

    private func setupParametersFor(
        requestType: Request.RequestType,
        url: inout URL,
        body: inout Data?
    ) {
        guard case .submitForm(let form) = requestType else { return }

        switch form.method {
        case .post, .put:
            configureBodyParameters(form.values, in: &body)

        case .get, .delete:
            configureURLParameters(form.values, in: &url)
        }
    }

    private func configureBodyParameters(
        _ parameters: [String: Any],
        in body: inout Data?
    ) {
        body = try? JSONSerialization.data(withJSONObject: parameters, options: [])
    }

    private func configureURLParameters(
        _ parameters: [String: String],
        in url: inout URL
    ) {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }

        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        if let newUrl = components.url {
            url = newUrl
        }
    }
}
