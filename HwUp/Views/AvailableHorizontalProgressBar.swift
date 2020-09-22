//
//  HwUpHorizontalProgressBar.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 21..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class AvailableHorizontalProgressBar: UIView {
    @IBInspectable var color: UIColor = .gray {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var background: UIColor = .orange {
        didSet { setNeedsDisplay() }
    }

    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    private let progressLayer = CALayer()
    private let backgroundLineLayer = CALayer()
    private let backgroundMask = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        layer.addSublayer(backgroundLineLayer)
        layer.addSublayer(progressLayer)
    }

    override func draw(_ rect: CGRect) {
        backgroundMask.path =
            UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.41).cgPath
        layer.mask = backgroundMask

        let progressRect = CGRect(
            origin: CGPoint(x: rect.width - (rect.width * progress), y: 0),
            size: CGSize(width: rect.width * progress, height: rect.height)
        )

        let backgroundHeight = rect.height / 3
        let backGroundPositionY = (rect.height / 2) - (backgroundHeight / 2)

        let backgroundRect = CGRect(
            origin: CGPoint(x: 0, y: backGroundPositionY),
            size: CGSize(width: rect.width, height: backgroundHeight)
        )

        backgroundLineLayer.frame = backgroundRect
        backgroundLineLayer.cornerRadius = backgroundHeight * 0.41
        backgroundLineLayer.backgroundColor = background.cgColor

        progressLayer.frame = progressRect
        progressLayer.cornerRadius = rect.height * 0.41
        progressLayer.backgroundColor = color.cgColor
    }
}
