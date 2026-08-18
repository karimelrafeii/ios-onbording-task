import Foundation
import Moya

final class ProductAPIService {
    
    private let provider: MoyaProvider<ProductAPI>
    
    init(
        provider: MoyaProvider<ProductAPI> = MoyaProvider<ProductAPI>()
    ) {
        self.provider = provider
    }
    
    func fetchProducts(
        completion: @escaping (Result<[Product], Error>) -> Void
    ) {
        provider.request(.getProducts) { result in
            
            switch result {
                
            case .success(let response):
                
                do {
                    let products = try JSONDecoder().decode(
                        [Product].self,
                        from: response.data
                    )
                    
                    completion(.success(products))
                    
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
