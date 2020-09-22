//
//  Float+ToFormattedString.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 22..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Foundation

extension Float {
    func formatFloatToString() -> String {
        _ = NumberFormatter()

        let formatter = NumberFormatter()

        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        formatter.groupingSeparator = "'"

        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
