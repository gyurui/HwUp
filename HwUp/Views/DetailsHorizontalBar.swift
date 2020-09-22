//
//  DetailsHorizontalBar.swift
//  HwUp
//
//  Created by Gyorgy Trum on 2020. 09. 21..
//  Copyright © 2020. Gyorgy Trum. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class DetailsHorizontalBar: UIView {
    @IBInspectable var color: UIColor = .gray {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var pendingColor: UIColor = .red {
        didSet { setNeedsDisplay() }
    }

    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    var pendingProgress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    private let progressLayer = CALayer()
    private let pendingProgressLayer = CALayer()
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
        layer.addSublayer(progressLayer)
        layer.addSublayer(pendingProgressLayer)
    }

    override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
        layer.mask = backgroundMask

        let progressRect = CGRect(
            origin: CGPoint(x: rect.width - (rect.width * progress), y: 0),
            size: CGSize(width: rect.width * progress, height: rect.height)
        )

        let pendingProgressRect = CGRect(
            origin: CGPoint(x: rect.width - (rect.width * (progress + pendingProgress)), y: 0),
            size: CGSize(width: rect.width * (pendingProgress), height: rect.height)
        )

        pendingProgressLayer.frame = pendingProgressRect
        pendingProgressLayer.backgroundColor = UIColor.withAlphaComponent(pendingColor)(0.6).cgColor

        progressLayer.frame = progressRect
        progressLayer.backgroundColor = color.cgColor
    }
}
