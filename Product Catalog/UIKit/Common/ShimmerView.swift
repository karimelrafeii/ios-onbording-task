//
//  ShimmerView.swift
//  Product Catalog
//

import UIKit

final class ShimmerView: UIView {

    private let gradientLayer = CAGradientLayer()
    private var isAnimating = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLayer() {
        backgroundColor = .systemGray5

        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.withAlphaComponent(0.6).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0.35, 0.5, 0.65]
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = CGRect(
            x: -bounds.width,
            y: 0,
            width: bounds.width * 3,
            height: bounds.height
        )

        startAnimatingIfNeeded()
    }

    private func startAnimatingIfNeeded() {
        guard !isAnimating, bounds.width > 0 else {
            return
        }
        isAnimating = true

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = 0
        animation.toValue = bounds.width * 2 / 3
        animation.duration = 1.5
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "shimmer")
    }
}
