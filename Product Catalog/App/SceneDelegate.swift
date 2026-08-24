//
//  SceneDelegate.swift
//  Product Catalog
//
//  Created by mpa on 23/08/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let viewModel = ProductListViewModel(
            fetchProductsUseCase: ProductUseCaseProvider.provide()
        )

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(
            rootViewController: ProductListViewController(viewModel: viewModel)
        )
        window.makeKeyAndVisible()

        self.window = window
    }
}
