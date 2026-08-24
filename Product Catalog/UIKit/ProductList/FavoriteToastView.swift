//
//  FavoriteToastView.swift
//  Product Catalog
//

import UIKit

final class FavoriteToastView: UIView {

    private let iconView = UIImageView()
    private let messageLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 4)

        iconView.contentMode = .scaleAspectFit

        messageLabel.font = .systemFont(ofSize: 18, weight: .bold)
        messageLabel.textAlignment = .center
        messageLabel.textColor = .black

        let stack = UIStackView(arrangedSubviews: [iconView, messageLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),

            stack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }

    func configure(message: String, systemImageName: String, tintColor: UIColor) {
        messageLabel.text = message
        iconView.image = UIImage(systemName: systemImageName)
        iconView.tintColor = tintColor
    }
}
