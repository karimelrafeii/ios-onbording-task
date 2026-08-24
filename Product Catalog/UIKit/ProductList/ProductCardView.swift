//
//  ProductCardView.swift
//  Product Catalog
//

import UIKit

final class ProductCardView: UIView {

    var onFavoriteTapped: (() -> Void)?

    private let imageView = CachedImageView()
    private let categoryLabel = UILabel()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        categoryLabel.textColor = .secondaryLabel
        categoryLabel.font = .systemFont(ofSize: 16)

        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        titleLabel.numberOfLines = 2

        priceLabel.font = .systemFont(ofSize: 24, weight: .medium)

        favoriteButton.backgroundColor = .white
        favoriteButton.layer.cornerRadius = 22
        favoriteButton.clipsToBounds = true
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)

        let textStack = UIStackView(arrangedSubviews: [categoryLabel, titleLabel, priceLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.alignment = .leading

        let mainStack = UIStackView(arrangedSubviews: [imageView, textStack])
        mainStack.axis = .vertical
        mainStack.spacing = 10
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStack)

        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(favoriteButton)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.heightAnchor.constraint(equalToConstant: 260),

            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func favoriteTapped() {
        onFavoriteTapped?()
    }

    func configure(with product: Product, isFavorite: Bool) {
        categoryLabel.text = product.category ?? "Category"
        titleLabel.text = product.title
        priceLabel.text = "$" + String(format: "%.2f", product.price)

        favoriteButton.setImage(
            UIImage(systemName: isFavorite ? "heart.fill" : "heart"),
            for: .normal
        )
        favoriteButton.tintColor = isFavorite ? .systemRed : .label

        imageView.load(url: product.imageURL)
    }

    func prepareForReuse() {
        imageView.prepareForReuse()
    }
}
