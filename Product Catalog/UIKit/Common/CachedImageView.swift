//
//  CachedImageView.swift
//  Product Catalog
//

import UIKit
import Combine

final class CachedImageView: UIView {

    private let imageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    private var imageLoader: ImageLoader?
    private var cancellable: AnyCancellable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func load(url: String) {
        cancellable?.cancel()
        imageView.image = nil
        activityIndicator.startAnimating()

        let loader = ImageLoader(url: url)
        imageLoader = loader

        cancellable = loader.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self else {
                    return
                }
                self.imageView.image = image
                if image != nil {
                    self.activityIndicator.stopAnimating()
                }
            }

        loader.load()
    }

    func prepareForReuse() {
        cancellable?.cancel()
        cancellable = nil
        imageLoader = nil
        imageView.image = nil
        activityIndicator.startAnimating()
    }
}
