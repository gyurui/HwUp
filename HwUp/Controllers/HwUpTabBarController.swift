//
//  HwUpTabBarController.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 20..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import UIKit

class HwUpTabBarController: UITabBarController {

    override func viewDidLoad() {
        let appearance = UITabBarAppearance()
        let itemAppearance = UITabBarItemAppearance()

        itemAppearance.normal.iconColor = UIColor.appColor(.navTextBlue)
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.appColor(.navTextBlue)!,
            .font: UIFont.init(name: "Roboto-Medium", size: 12.15)!, .kern: 0.4,
        ]

        itemAppearance.selected.iconColor = UIColor.appColor(.statusBlue)
        itemAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.appColor(.statusBlue)!,
            .font: UIFont.init(name: "Roboto-Bold", size: 12.15)!, .kern: 0.4,
        ]

        itemAppearance.normal.badgeBackgroundColor = UIColor.appColor(.badgeOrange)
        itemAppearance.normal.badgeTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.init(name: "Roboto-Medium", size: 12.15)!,
        ]

        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance

        appearance.backgroundColor = UIColor.white
        appearance.stackedItemWidth = 0.0

        tabBar.standardAppearance = appearance
    }

}
