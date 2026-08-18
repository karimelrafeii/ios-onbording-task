import Foundation
import Moya

enum ProductAPI {
    case getProducts
}

extension ProductAPI: TargetType {
    
    var baseURL: URL {
        URL(string: "https://fakestoreapi.com")!
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProducts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getProducts:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
