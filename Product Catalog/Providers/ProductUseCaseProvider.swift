

final class ProductUseCaseProvider {
    
    static func provide() -> FetchProductsUseCase {
        let productRepository = ProductRepositoryProvider.provide()
        return FetchProductsUseCase(repository:  productRepository)
    }
}
