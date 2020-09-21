//
//  ApiRouter.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 20..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Alamofire
import Foundation

enum APIRouter: URLRequestConvertible {

    // MARK: - Endpoints
    case getCards

    // MARK: - Properties
    private var method: HTTPMethod {
        switch self {
        case .getCards:
            return .get
        }
    }

    private var path: String {
        switch self {
        case .getCards:
            return "master/api/v1/cards.json"
        }
    }

    private var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }

    private var body: Parameters? {
        switch self {
        default:
            return nil
        }
    }

    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        // Construct url
        let url = try NetworkConstants.baseURL.asURL()

        // Append path
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // Determine HTTP method
        urlRequest.httpMethod = method.rawValue

        // Set common headers
        urlRequest.setValue(
            NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
            forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.acceptType.rawValue
        )
        urlRequest.setValue(
            NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
            forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.contentType.rawValue
        )

        // Add http body to request
        if let body = body {
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                urlRequest.httpBody = data
            }
            catch (_) {
                print("APIRouter: Failed to parse body into request.")
            }
        }

        // Add query parameters to request
        if let parameters = parameters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}
