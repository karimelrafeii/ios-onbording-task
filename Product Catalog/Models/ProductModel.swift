import SwiftUICore

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

struct FavoritePopup {
    let message: String
    let icon: String
    let color: Color
}
