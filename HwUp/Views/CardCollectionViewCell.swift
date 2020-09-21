//
//  CardCollectionViewCell.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 21..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!

    func setUp(card: Card) {
        imageView.image = UIImage.init(named: CardNames.getAssetName(cardImageName: card.cardImage))

        shadowView.layer.cornerRadius = 7.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        shadowView.layer.shadowOpacity = 0.29
        shadowView.layer.shadowOpacity = 1
    }
}
