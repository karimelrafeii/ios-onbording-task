
struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let category: String?
    let price: Double
    let imageURL: String
    let rating: Rating?
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case category
        case price
        case imageURL = "image"
        case rating
    }
}

struct Rating:  Codable{
    let rate: Double
    let count: Int
}




let dummyProducts: [Product] = [
    Product(
        id: 1,
        title: "Minimalist Chair",
        description: "Minimalist chair lounge",
        category: "Furniture",
        price: 849.00,
        imageURL: "https://example.com/chair.jpg",
        rating: Rating(
            rate: 4.5,
            count: 120
        )
    ),

    Product(
        id: 2,
        title: "Modern Sofa",
        description: "Comfortable modern sofa",
        category: "Furniture",
        price: 1299.00,
        imageURL: "https://example.com/sofa.jpg",
        rating: Rating(
            rate: 4.7,
            count: 89
        )
    ),

    Product(
        id: 3,
        title: "Wooden Coffee Table",
        description: "Simple wooden coffee table",
        category: "Furniture",
        price: 499.00,
        imageURL: "https://example.com/table.jpg",
        rating: Rating(
            rate: 4.3,
            count: 156
        )
    ),

    Product(
        id: 4,
        title: "Modern Floor Lamp",
        description: "Elegant floor lamp for your living room",
        category: "Lighting",
        price: 299.00,
        imageURL: "https://example.com/lamp.jpg",
        rating: Rating(
            rate: 4.6,
            count: 73
        )
    ),

    Product(
        id: 5,
        title: "Leather Armchair",
        description: "Premium leather lounge chair",
        category: "Furniture",
        price: 999.00,
        imageURL: "https://example.com/armchair.jpg",
        rating: Rating(
            rate: 4.8,
            count: 201
        )
    )
]



