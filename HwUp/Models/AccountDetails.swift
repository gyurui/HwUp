//
//  AccountDetails.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 20..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Foundation

public struct AccountDetails {
    public let accountLimit: Int
    public let accountNumber: String
}

extension AccountDetails: Codable {
    enum CodingKeys: String, CodingKey {
        case accountLimit = "accountLimit"
        case accountNumber = "accountNumber"
    }
}
