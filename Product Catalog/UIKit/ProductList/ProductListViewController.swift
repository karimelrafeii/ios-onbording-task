//
//  ProductListViewController.swift
//  Product Catalog
//

import UIKit
import Combine
import L10n_swift

final class ProductListViewController: UIViewController {

    private let viewModel: ProductListViewModel

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let headerView = ProductListHeaderView()
    private let refreshControl = UIRefreshControl()
    private let favoriteToastView = FavoriteToastView()

    private var cancellables = Set<AnyCancellable>()

    private let skeletonRowCount = 4

    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setUpTableView()
        setUpHeaderView()
        setUpFavoriteToast()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutHeaderViewIfNeeded()
    }

    // MARK: - Setup

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ProductCardCell.self, forCellReuseIdentifier: ProductCardCell.reuseIdentifier)
        tableView.register(ProductSkeletonCell.self, forCellReuseIdentifier: ProductSkeletonCell.reuseIdentifier)

        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setUpHeaderView() {
        headerView.onLanguageToggleTapped = { [weak self] in
            self?.viewModel.toggleLanguage()
        }
        headerView.onSearchTextChanged = { [weak self] text in
            self?.viewModel.searchText = text
            self?.viewModel.search()
        }

        let container = UIView()

        headerView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(headerView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            headerView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            headerView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])

        container.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        tableView.tableHeaderView = container
    }

    private func setUpFavoriteToast() {
        favoriteToastView.alpha = 0
        favoriteToastView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favoriteToastView)

        NSLayoutConstraint.activate([
            favoriteToastView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteToastView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            favoriteToastView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 40),
            favoriteToastView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40)
        ])
    }

    private func layoutHeaderViewIfNeeded() {
        guard let headerContainer = tableView.tableHeaderView else {
            return
        }

        let width = tableView.bounds.width
        let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        let size = headerContainer.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        if headerContainer.frame.height != size.height {
            headerContainer.frame.size = CGSize(width: width, height: size.height)
            tableView.tableHeaderView = headerContainer
        }
    }

    // MARK: - Bindings

    private func bindViewModel() {
        viewModel.$searchedProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else {
                    return
                }
                self.tableView.reloadData()
                if !isLoading {
                    self.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)

        viewModel.$favoriteProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$currentLanguage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentLanguage in
                self?.updateHeaderTexts(currentLanguage: currentLanguage)
            }
            .store(in: &cancellables)

        viewModel.$showFavoritePopup
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isVisible in
                self?.setFavoriteToastVisible(isVisible)
            }
            .store(in: &cancellables)
    }

    private func updateHeaderTexts(currentLanguage: String) {
        headerView.configure(
            title: "new_arrival".l10n(),
            subtitle: "discover".l10n(),
            languageButtonTitle: currentLanguage == "en" ? "عربي" : "English"
        )
    }

    private func setFavoriteToastVisible(_ isVisible: Bool) {
        if isVisible, let popup = viewModel.favoritePopup {
            favoriteToastView.configure(
                message: popup.message,
                systemImageName: popup.icon,
                tintColor: popup.icon == "heart.fill" ? .systemRed : .black
            )
        }

        UIView.animate(withDuration: 0.25) {
            self.favoriteToastView.alpha = isVisible ? 1 : 0
        }
    }

    @objc private func handleRefresh() {
        viewModel.fetchProducts()
    }
}

// MARK: - UITableViewDataSource

extension ProductListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.isLoading ? skeletonRowCount : viewModel.searchedProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isLoading {
            return tableView.dequeueReusableCell(
                withIdentifier: ProductSkeletonCell.reuseIdentifier,
                for: indexPath
            )
        }

        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductCardCell.reuseIdentifier,
            for: indexPath
        ) as! ProductCardCell

        let product = viewModel.searchedProducts[indexPath.row]
        let isFavorite = viewModel.favoriteProducts.contains(product.id)

        cell.configure(with: product, isFavorite: isFavorite)
        cell.onFavoriteTapped = { [weak self] in
            self?.viewModel.toggleFavorite(product: product)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProductListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard !viewModel.isLoading else {
            return
        }

        let product = viewModel.searchedProducts[indexPath.row]
        let detailsViewModel = ProductDetailsModelView(
            cartRepository: CartRepositoryProvider.provide()
        )
        let detailsViewController = ProductDetailsViewController(
            product: product,
            viewModel: detailsViewModel
        )
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
