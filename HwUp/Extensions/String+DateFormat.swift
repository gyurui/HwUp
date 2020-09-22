//
//  String+DateFormat.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 22..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Foundation

extension String {
    func formatDate() -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let secondDateFormatter = DateFormatter()
        secondDateFormatter.dateFormat = "yyyy.MM.dd."

        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd.MM.yyyy"

        if let old = dateFormatter.date(from: self) {
            return convertDateFormatter.string(from: old)
        }

        if let old = secondDateFormatter.date(from: self) {
            return convertDateFormatter.string(from: old)
        }

        return self
    }
}
