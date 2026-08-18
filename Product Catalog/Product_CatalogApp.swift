import SwiftUI
import Moya

@main
struct Product_CatalogApp: App {
    
    private let productListModelView: ProductListModelView
    
    init() {
        
        // 1. Create Moya provider
        let provider = MoyaProvider<ProductAPI>()
        
        // 2. Inject provider into repository
        let repository = ProductRepository(
            provider: provider
        )
        
        // 3. Inject repository into use case
        let fetchProductsUseCase = FetchProductsUseCase(
            repository: repository
        )
        
        // 4. Inject use case into ViewModel
        self.productListModelView = ProductListModelView(
            fetchProductsUseCase: fetchProductsUseCase
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ProductListView(
                productListModelView: productListModelView
            )
        }
    }
}
