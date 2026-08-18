import SwiftUI

class ProductDetailsModelView: ObservableObject {

    // MARK: - Quantity

    @Published var quantity = 1


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


    // MARK: - Cart

    @Published var cartItems: [CartItem] = []

    @Published var isAddedToCart = false


    private let cartKey = "cartItems"


    // MARK: - Init

    init() {
        loadCart()
    }


    // MARK: - Quantity

    func increaseQuantity() {
        quantity += 1
    }


    func decreaseQuantity() {

        if quantity > 1 {
            quantity -= 1
        }
    }


    // MARK: - Color

    func selectColor(_ color: Int) {
        selectedColor = color
    }


    // MARK: - Cart

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

        saveCart()

        isAddedToCart = true
    }


    // MARK: - Remove From Cart

    func removeFromCart(product: Product) {

        cartItems.removeAll {
            $0.product.id == product.id &&
            $0.selectedColor == selectedColor
        }

        saveCart()

        isAddedToCart = false
    }


    // MARK: - Save Cart

    private func saveCart() {

        guard let data = try? JSONEncoder().encode(
            cartItems
        ) else {
            return
        }

        UserDefaults.standard.set(
            data,
            forKey: cartKey
        )
    }


    // MARK: - Load Cart

    private func loadCart() {

        guard let data = UserDefaults.standard.data(
            forKey: cartKey
        ) else {
            return
        }

        guard let savedCart = try? JSONDecoder().decode(
            [CartItem].self,
            from: data
        ) else {
            return
        }

        cartItems = savedCart
    }


    // MARK: - Check Cart

    func checkIfProductIsInCart(product: Product) {

        isAddedToCart = cartItems.contains {
            $0.product.id == product.id &&
            $0.selectedColor == selectedColor
        }
    }
}
