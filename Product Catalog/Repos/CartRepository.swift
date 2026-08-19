import Foundation

final class CartRepository {
    
    private let cartKey = "cartItems"
    
    // MARK: - Save Cart
    
    func saveCart(_ cartItems: [CartItem]) {
        guard let data = try? JSONEncoder().encode(cartItems) else {
            return
        }
        
        UserDefaults.standard.set(
            data,
            forKey: cartKey
        )
    }
    
    // MARK: - Load Cart
    
    func loadCart() -> [CartItem] {
        guard let data = UserDefaults.standard.data(
            forKey: cartKey
        ) else {
            return []
        }
        
        guard let savedCart = try? JSONDecoder().decode(
            [CartItem].self,
            from: data
        ) else {
            return []
        }
        
        return savedCart
    }
}
