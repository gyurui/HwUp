//
//  CardDetailsItem .swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 21..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Foundation

struct CardDetailsItem {
    let labelName: String
    let isShowCurrency: Bool
    let value: String
    var isLongerInformationCell: Bool = false
    var isShowDecorationLine: Bool = false
}
