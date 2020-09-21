//
//  CardNames.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 21..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Foundation

struct CardNames {
    static func getAssetName(cardImageName: String) -> String {
        switch cardImageName {
        case "1":
            return "card"
        case "2":
            return "card2"
        case "3":
            return "card3"
        default:
            return "card"
        }
    }
}
