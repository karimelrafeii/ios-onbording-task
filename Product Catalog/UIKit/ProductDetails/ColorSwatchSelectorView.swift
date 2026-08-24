//
//  ColorSwatchSelectorView.swift
//  Product Catalog
//

import UIKit

final class ColorSwatchSelectorView: UIView {

    var onColorSelected: ((Int) -> Void)?

    private let titleLabel = UILabel()
    private let swatchStack = UIStackView()

    private var swatchButtons: [UIButton] = []
    private var colors: [UIColor] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        titleLabel.text = "COLOR"
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)

        swatchStack.axis = .horizontal
        swatchStack.spacing = 12

        let stack = UIStackView(arrangedSubviews: [titleLabel, swatchStack])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func configure(colors: [UIColor], selectedIndex: Int) {
        self.colors = colors

        swatchStack.arrangedSubviews.forEach {
            swatchStack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        swatchButtons = []

        for (index, color) in colors.enumerated() {
            let button = UIButton(type: .custom)
            button.backgroundColor = color
            button.layer.cornerRadius = 20
            button.tag = index
            button.addTarget(self, action: #selector(swatchTapped(_:)), for: .touchUpInside)

            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true

            swatchStack.addArrangedSubview(button)
            swatchButtons.append(button)
        }

        updateSelection(selectedIndex)
    }

    func updateSelection(_ selectedIndex: Int) {
        for (index, button) in swatchButtons.enumerated() {
            if index == selectedIndex {
                button.layer.borderWidth = 4
                button.layer.borderColor = colors[index].cgColor
            } else {
                button.layer.borderWidth = 0
            }
        }
    }

    @objc private func swatchTapped(_ sender: UIButton) {
        onColorSelected?(sender.tag)
    }
}
