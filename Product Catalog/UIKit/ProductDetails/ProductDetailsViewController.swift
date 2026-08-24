//
//  ProductDetailsViewController.swift
//  Product Catalog
//

import UIKit
import SwiftUI
import Combine

final class ProductDetailsViewController: UIViewController {

    private let product: Product
    private let viewModel: ProductDetailsModelView

    private let imageSection = ProductImageSectionView()
    private let infoSection = ProductInfoSectionView()
    private let descriptionSection = ProductDescriptionSectionView()
    private let optionsSection = ProductOptionsSectionView()
    private let actionsSection = ProductActionsSectionView()

    private var cancellables = Set<AnyCancellable>()

    init(product: Product, viewModel: ProductDetailsModelView) {
        self.product = product
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setUpLayout()
        setUpActions()
        configureStaticContent()
        bindViewModel()

        viewModel.checkIfProductIsInCart(product: product)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Setup

    private func setUpLayout() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let contentStack = UIStackView(arrangedSubviews: [
            imageSection,
            infoSection,
            descriptionSection,
            optionsSection,
            actionsSection
        ])
        contentStack.axis = .vertical
        contentStack.spacing = 15
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func setUpActions() {
        optionsSection.colorSelector.onColorSelected = { [weak self] index in
            self?.viewModel.selectColor(index)
        }

        optionsSection.quantityStepper.onDecreaseTapped = { [weak self] in
            self?.viewModel.decreaseQuantity()
        }
        optionsSection.quantityStepper.onIncreaseTapped = { [weak self] in
            self?.viewModel.increaseQuantity()
        }

        actionsSection.cartButton.onTapped = { [weak self] in
            guard let self else {
                return
            }
            self.viewModel.handleCartButton(product: self.product)
        }
    }

    private func configureStaticContent() {
        infoSection.configure(with: product)
        descriptionSection.configure(with: product)

        let uiColors = viewModel.colors.map { UIColor($0) }
        optionsSection.colorSelector.configure(colors: uiColors, selectedIndex: viewModel.selectedColor)
        optionsSection.quantityStepper.configure(quantity: viewModel.quantity)
        updateCartButton()
    }

    // MARK: - Bindings

    private func bindViewModel() {
        viewModel.$quantity
            .receive(on: DispatchQueue.main)
            .sink { [weak self] quantity in
                self?.optionsSection.quantityStepper.configure(quantity: quantity)
            }
            .store(in: &cancellables)

        viewModel.$selectedColor
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedColor in
                self?.optionsSection.colorSelector.updateSelection(selectedColor)
            }
            .store(in: &cancellables)

        viewModel.$isAddedToCart
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateCartButton()
            }
            .store(in: &cancellables)
    }

    private func updateCartButton() {
        actionsSection.cartButton.configure(
            title: viewModel.cartButtonText,
            systemImageName: viewModel.cartButtonIcon,
            backgroundColor: UIColor(viewModel.cartButtonColor)
        )
    }
}
