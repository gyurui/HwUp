//
//  NetworkConstatnts.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 20..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Foundation

struct NetworkConstants {

    // Base URL
    static let baseURL = "https://raw.githubusercontent.com/wupdigital/interview-api/"

    enum HTTPHeaderFieldKey: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    enum HTTPHeaderFieldValue: String {
        case json = "application/json"
    }

}
