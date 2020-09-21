//
//  MyError.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 20..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Foundation

public enum MyError: Error {

    // MARK: - Internal errors
    case noInternet

    // MARK: - API errors
    case badAPIRequest

    // MARK: - Auth errors
    case unauthorized

    // MARK: - Unknown errors
    case unknown
}
