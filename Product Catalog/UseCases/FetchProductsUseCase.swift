import Foundation

final class FetchProductsUseCase {
    
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(
        completion: @escaping (Result<[Product], Error>) -> Void
    ) {
        repository.fetchProducts { result in
            completion(result)
        }
    }
}
