//
//  ProductDescriptionSectionView.swift
//  Product Catalog
//

import UIKit

final class ProductDescriptionSectionView: UIView {

    private let headingLabel = UILabel()
    private let bodyLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        headingLabel.text = "DESCRIPTION"
        headingLabel.font = .systemFont(ofSize: 16, weight: .heavy)

        bodyLabel.font = .systemFont(ofSize: 16)
        bodyLabel.textColor = .secondaryLabel
        bodyLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [headingLabel, bodyLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    func configure(with product: Product) {
        bodyLabel.text = product.description
    }
}
