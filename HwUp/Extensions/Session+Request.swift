//
//  Alamofire+Session.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 20..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

extension Session {
    func request<T: Codable>(_ urlConvertible: APIRouter) -> Promise<T> {
        return Promise<T> { seal in
            // Trigger the HTTPRequest using Alamofire
            request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                // Check result from response and map it the the promise
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                case .failure:
                    // If it's a failure, check status code and map it to my error
                    switch response.response?.statusCode {
                    case 400:
                        seal.reject(MyError.badAPIRequest)
                    case 401:
                        seal.reject(MyError.unauthorized)
                    default:
                        guard NetworkReachabilityManager()?.isReachable ?? false else {
                            seal.reject(MyError.noInternet)
                            return
                        }
                        print(response)
                        seal.reject(MyError.unknown)
                    }
                }
            }
        }
    }
}
