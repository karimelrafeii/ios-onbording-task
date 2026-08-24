//
//  CartActionButton.swift
//  Product Catalog
//

import UIKit

final class CartActionButton: UIView {

    var onTapped: (() -> Void)?

    private let button = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)

        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 20
        button.configuration = configuration

        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    @objc private func tapped() {
        onTapped?()
    }

    func configure(title: String, systemImageName: String, backgroundColor: UIColor) {
        button.setImage(UIImage(systemName: systemImageName), for: .normal)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
    }
}
