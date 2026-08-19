import Foundation
import Moya

enum ProductAPI {
    case getProducts
}

extension ProductAPI: TargetType {
    
    var baseURL: URL {
        URL(string: "https://free.mockerapi.com/mock/720362ed-3437-45a5-b88b-d564159ca9bb")!
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return ""
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
