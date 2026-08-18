import SwiftUI

enum FavoriteAction {
    case added
    case removed
}
class ProductListModelView: ObservableObject {

    @Published var searchText: String = ""

    @Published var favoriteProducts: Set<Int> = []

    @Published var showFavoritePopup = false

    @Published var favoriteAction: FavoriteAction = .added
    @Published var searchedProducts: [Product] = dummyProducts
    private let favoritesKey = "favoriteProducts"


    init() {
        loadFavorites()
    }


    // MARK: - Favorite Handling

    func toggleFavorite(product: Product) {

        if favoriteProducts.contains(product.id) {

            favoriteProducts.remove(product.id)

            favoriteAction = .removed

        } else {

            favoriteProducts.insert(product.id)

            favoriteAction = .added
        }

        saveFavorites()

        showPopup()
    }


    // MARK: - Save Favorites

    private func saveFavorites() {

        guard let data = try? JSONEncoder().encode(
            favoriteProducts
        ) else {
            return
        }

        UserDefaults.standard.set(
            data,
            forKey: favoritesKey
        )
    }


    // MARK: - Load Favorites

    private func loadFavorites() {

        guard let data = UserDefaults.standard.data(
            forKey: favoritesKey
        ) else {
            return
        }

        guard let favorites = try? JSONDecoder().decode(
            Set<Int>.self,
            from: data
        ) else {
            return
        }

        favoriteProducts = favorites
    }


    // MARK: - Popup

    private func showPopup() {

        showFavoritePopup = true

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1
        ) {
            self.showFavoritePopup = false
        }
    }
    // MARK: -Search
     func search() {
        if searchText.isEmpty {
            searchedProducts = dummyProducts
        } else {
            searchedProducts = dummyProducts.filter { product in
                product.title.localizedCaseInsensitiveContains(searchText)
                || product.category?.localizedCaseInsensitiveContains(searchText) == true
            }
        }
    }
    
}
