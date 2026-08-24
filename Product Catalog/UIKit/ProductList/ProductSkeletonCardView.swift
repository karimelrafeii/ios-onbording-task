//
//  ProductSkeletonCardView.swift
//  Product Catalog
//

import UIKit

final class ProductSkeletonCardView: UIView {

    private let imageShimmer = ShimmerView()
    private let categoryShimmer = ShimmerView()
    private let titleShimmer = ShimmerView()
    private let priceShimmer = ShimmerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        let shimmers: [(view: ShimmerView, cornerRadius: CGFloat)] = [
            (imageShimmer, 15),
            (categoryShimmer, 5),
            (titleShimmer, 5),
            (priceShimmer, 5)
        ]

        for entry in shimmers {
            entry.view.layer.cornerRadius = entry.cornerRadius
            entry.view.clipsToBounds = true
            entry.view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(entry.view)
        }

        NSLayoutConstraint.activate([
            imageShimmer.topAnchor.constraint(equalTo: topAnchor),
            imageShimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageShimmer.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageShimmer.heightAnchor.constraint(equalToConstant: 260),

            categoryShimmer.topAnchor.constraint(equalTo: imageShimmer.bottomAnchor, constant: 10),
            categoryShimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryShimmer.widthAnchor.constraint(equalToConstant: 100),
            categoryShimmer.heightAnchor.constraint(equalToConstant: 18),

            titleShimmer.topAnchor.constraint(equalTo: categoryShimmer.bottomAnchor, constant: 10),
            titleShimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleShimmer.widthAnchor.constraint(equalToConstant: 250),
            titleShimmer.heightAnchor.constraint(equalToConstant: 25),

            priceShimmer.topAnchor.constraint(equalTo: titleShimmer.bottomAnchor, constant: 10),
            priceShimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceShimmer.widthAnchor.constraint(equalToConstant: 100),
            priceShimmer.heightAnchor.constraint(equalToConstant: 28),
            priceShimmer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
