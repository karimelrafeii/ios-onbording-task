//
//  ProductListHeaderView.swift
//  Product Catalog
//

import UIKit

final class ProductListHeaderView: UIView {

    var onLanguageToggleTapped: (() -> Void)?
    var onSearchTextChanged: ((String) -> Void)?

    private let titleLabel = UILabel()
    private let languageButton = UIButton(type: .system)
    private let subtitleLabel = UILabel()
    private let searchField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        titleLabel.font = .systemFont(ofSize: 34, weight: .heavy)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        languageButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        languageButton.setContentHuggingPriority(.required, for: .horizontal)
        languageButton.addTarget(self, action: #selector(languageTapped), for: .touchUpInside)

        let titleRow = UIStackView(arrangedSubviews: [titleLabel, languageButton])
        titleRow.axis = .horizontal
        titleRow.alignment = .center
        titleRow.distribution = .equalSpacing

        subtitleLabel.font = .systemFont(ofSize: 18)
        subtitleLabel.textColor = .secondaryLabel

        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = .secondaryLabel
        searchIcon.contentMode = .scaleAspectFit

        searchField.placeholder = "Search products..."
        searchField.font = .systemFont(ofSize: 18)
        searchField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)

        let searchRow = UIStackView(arrangedSubviews: [searchIcon, searchField])
        searchRow.axis = .horizontal
        searchRow.spacing = 12
        searchRow.alignment = .center
        searchRow.isLayoutMarginsRelativeArrangement = true
        searchRow.layoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        searchRow.backgroundColor = .systemGray6
        searchRow.layer.cornerRadius = 22
        searchRow.clipsToBounds = true
        searchRow.translatesAutoresizingMaskIntoConstraints = false

        let mainStack = UIStackView(arrangedSubviews: [titleRow, subtitleLabel, searchRow])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.setCustomSpacing(24, after: subtitleLabel)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStack)

        NSLayoutConstraint.activate([
            searchIcon.widthAnchor.constraint(equalToConstant: 24),
            searchIcon.heightAnchor.constraint(equalToConstant: 24),
            searchRow.heightAnchor.constraint(equalToConstant: 64),

            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func languageTapped() {
        onLanguageToggleTapped?()
    }

    @objc private func searchTextChanged() {
        onSearchTextChanged?(searchField.text ?? "")
    }

    func configure(title: String, subtitle: String, languageButtonTitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        languageButton.setTitle(languageButtonTitle, for: .normal)
    }
}
