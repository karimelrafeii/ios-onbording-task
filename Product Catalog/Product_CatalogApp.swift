import SwiftUI

@main
struct Product_CatalogApp: App {
    
    private let useCase = ProductUseCaseProvider.provide()
    
    var body: some Scene {
        WindowGroup {
            ProductListView(
                productListViewModel: ProductListViewModel(
                    fetchProductsUseCase: useCase
                )
            )
        }
    }
}
