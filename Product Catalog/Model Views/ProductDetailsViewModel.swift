import SwiftUI

final class ProductDetailsModelView: ObservableObject {
    
    // MARK: - Repository
    
    private let cartRepository: CartRepository
    
    
    // MARK: - Quantity
    
    @Published var quantity = 1
    
    func increaseQuantity() {
        quantity += 1
    }
    
    func decreaseQuantity() {
        if quantity > 1 {
            quantity -= 1
        }
    }
    
    
    // MARK: - Color
    
    @Published var selectedColor = 0
    
    let colors: [Color] = [
        .black,
        Color(
            red: 0.88,
            green: 0.89,
            blue: 0.91
        ),
        Color(
            red: 0.78,
            green: 0.72,
            blue: 0.66
        )
    ]
    
    func selectColor(_ color: Int) {
        selectedColor = color
    }
    
    
    // MARK: - Cart
    
    @Published var cartItems: [CartItem] = []
    @Published var isAddedToCart = false
    
    var cartButtonText: String {
        isAddedToCart ? "Added to Cart" : "Add to Cart"
    }
    
    var cartButtonIcon: String {
        isAddedToCart ? "checkmark" : "cart.fill"
    }
    
    var cartButtonColor: Color {
        isAddedToCart ? .gray : .black
    }
    
    
    // MARK: - Init
    
    init(cartRepository: CartRepository) {
        self.cartRepository = cartRepository
        self.cartItems = cartRepository.loadCart()
    }
    
    
    // MARK: - Cart Actions
    
    func handleCartButton(product: Product) {
        if isAddedToCart {
            removeFromCart(product: product)
        } else {
            addToCart(product: product)
        }
    }
    
    func addToCart(product: Product) {
        
        if let index = cartItems.firstIndex(
            where: { cartItem in
                cartItem.product.id == product.id &&
                cartItem.selectedColor == selectedColor
            }
        ) {
            cartItems[index].quantity += quantity
            
        } else {
            let cartItem = CartItem(
                id: product.id,
                product: product,
                quantity: quantity,
                selectedColor: selectedColor
            )
            
            cartItems.append(cartItem)
        }
        
        cartRepository.saveCart(cartItems)
        isAddedToCart = true
    }
    
    
    func removeFromCart(product: Product) {
        
        cartItems.removeAll {
            $0.product.id == product.id &&
            $0.selectedColor == selectedColor
        }
        
        cartRepository.saveCart(cartItems)
        isAddedToCart = false
    }
    
    
    // MARK: - Check Cart
    
    func checkIfProductIsInCart(product: Product) {
        isAddedToCart = cartItems.contains {
            $0.product.id == product.id &&
            $0.selectedColor == selectedColor
        }
    }
}
