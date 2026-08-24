//
//  ProductOptionsSectionView.swift
//  Product Catalog
//

import UIKit

final class ProductOptionsSectionView: UIView {

    let colorSelector = ColorSwatchSelectorView()
    let quantityStepper = QuantityStepperView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        let stack = UIStackView(arrangedSubviews: [colorSelector, UIView(), quantityStepper])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
