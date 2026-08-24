//
//  QuantityStepperView.swift
//  Product Catalog
//

import UIKit

final class QuantityStepperView: UIView {

    var onDecreaseTapped: (() -> Void)?
    var onIncreaseTapped: (() -> Void)?

    private let titleLabel = UILabel()
    private let quantityLabel = UILabel()
    private let minusButton = UIButton(type: .system)
    private let plusButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        titleLabel.text = "QUANTITY"
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)

        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        minusButton.tintColor = .label
        minusButton.addTarget(self, action: #selector(decreaseTapped), for: .touchUpInside)

        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        plusButton.tintColor = .label
        plusButton.addTarget(self, action: #selector(increaseTapped), for: .touchUpInside)

        quantityLabel.font = .systemFont(ofSize: 20, weight: .medium)
        quantityLabel.textAlignment = .center

        let controlRow = UIStackView(arrangedSubviews: [minusButton, quantityLabel, plusButton])
        controlRow.axis = .horizontal
        controlRow.spacing = 20
        controlRow.alignment = .center
        controlRow.distribution = .equalCentering
        controlRow.backgroundColor = .systemGray6
        controlRow.layer.cornerRadius = 20
        controlRow.clipsToBounds = true
        controlRow.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [titleLabel, controlRow])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            controlRow.widthAnchor.constraint(equalToConstant: 140),
            controlRow.heightAnchor.constraint(equalToConstant: 55),

            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    @objc private func decreaseTapped() {
        onDecreaseTapped?()
    }

    @objc private func increaseTapped() {
        onIncreaseTapped?()
    }

    func configure(quantity: Int) {
        quantityLabel.text = "\(quantity)"
    }
}
