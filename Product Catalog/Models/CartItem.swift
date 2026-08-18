import Foundation

struct CartItem: Codable, Identifiable {

    let id: Int
    let product: Product
    var quantity: Int
    var selectedColor: Int
}
