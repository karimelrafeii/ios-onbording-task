import Foundation

final class ProductRepository: ProductRepositoryProtocol {
    
    private let apiService: ProductAPIService
    
    init(apiService: ProductAPIService) {
        self.apiService = apiService
    }
    
    func fetchProducts(
        completion: @escaping (Result<[Product], Error>) -> Void
    ) {
        apiService.fetchProducts { result in
            completion(result)
        }
    }
}
