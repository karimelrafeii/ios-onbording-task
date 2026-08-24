//
//  ProductInfoSectionView.swift
//  Product Catalog
//

import UIKit

final class ProductInfoSectionView: UIView {

    private let categoryLabel = UILabel()
    private let ratingIcon = UIImageView(image: UIImage(systemName: "star.fill"))
    private let ratingValueLabel = UILabel()
    private let ratingCountLabel = UILabel()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        categoryLabel.textColor = .secondaryLabel
        categoryLabel.font = .systemFont(ofSize: 18, weight: .medium)

        ratingIcon.tintColor = .systemYellow
        ratingIcon.contentMode = .scaleAspectFit

        ratingValueLabel.font = .systemFont(ofSize: 16, weight: .heavy)

        ratingCountLabel.font = .systemFont(ofSize: 14)
        ratingCountLabel.textColor = .secondaryLabel

        let ratingStack = UIStackView(arrangedSubviews: [ratingIcon, ratingValueLabel, ratingCountLabel])
        ratingStack.axis = .horizontal
        ratingStack.spacing = 4
        ratingStack.alignment = .center

        let topRow = UIStackView(arrangedSubviews: [categoryLabel, UIView(), ratingStack])
        topRow.axis = .horizontal
        topRow.alignment = .center

        titleLabel.font = .systemFont(ofSize: 34, weight: .heavy)
        titleLabel.numberOfLines = 0

        priceLabel.font = .systemFont(ofSize: 28, weight: .medium)

        let mainStack = UIStackView(arrangedSubviews: [topRow, titleLabel, priceLabel])
        mainStack.axis = .vertical
        mainStack.spacing = 15
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStack)

        NSLayoutConstraint.activate([
            ratingIcon.widthAnchor.constraint(equalToConstant: 16),
            ratingIcon.heightAnchor.constraint(equalToConstant: 16),

            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    func configure(with product: Product) {
        categoryLabel.text = product.category ?? ""
        ratingValueLabel.text = String(format: "%.1f", product.rating?.rate ?? 0)
        ratingCountLabel.text = "(\(product.rating?.count ?? 0) reviews)"
        titleLabel.text = product.title
        priceLabel.text = "$" + String(format: "%.2f", product.price)
    }
}
