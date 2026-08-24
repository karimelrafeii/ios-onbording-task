//
//  ShareIconButton.swift
//  Product Catalog
//

import UIKit

final class ShareIconButton: UIView {

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
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .label
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: 60),
            button.heightAnchor.constraint(equalToConstant: 65)
        ])
    }

    @objc private func tapped() {
        onTapped?()
    }
}
