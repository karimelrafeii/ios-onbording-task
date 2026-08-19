
final class ProductRepositoryProvider {
    
    static func provide() -> ProductRepository {
        let apiService = APIServiceProvider.provide()
        return ProductRepository(apiService: apiService)
    }
}
