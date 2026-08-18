import Foundation

protocol ProductRepositoryProtocol {
    
    func fetchProducts(
        completion: @escaping (Result<[Product], Error>) -> Void
    )
}
