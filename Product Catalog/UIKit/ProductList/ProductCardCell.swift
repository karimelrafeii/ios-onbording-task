//
//  ProductCardCell.swift
//  Product Catalog
//

import UIKit

final class ProductCardCell: UITableViewCell {

    static let reuseIdentifier = "ProductCardCell"

    var onFavoriteTapped: (() -> Void)?

    private let cardView = ProductCardView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        selectionStyle = .none

        cardView.onFavoriteTapped = { [weak self] in
            self?.onFavoriteTapped?()
        }

        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with product: Product, isFavorite: Bool) {
        cardView.configure(with: product, isFavorite: isFavorite)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.prepareForReuse()
        onFavoriteTapped = nil
    }
}
