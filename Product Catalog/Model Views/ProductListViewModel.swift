import SwiftUI

final class ProductListViewModel: ObservableObject {
    
    private let fetchProductsUseCase: FetchProductsUseCase
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
        loadFavorites()
        fetchProducts()
    }
    
    // MARK: - Published Properties
    
    @Published var searchText: String = ""
    @Published var favoriteProducts: Set<Int> = []
    @Published var showFavoritePopup = false
    @Published var products: [Product] = []
    @Published var searchedProducts: [Product] = []
    @Published var favoritePopup: FavoritePopup?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    
    
    // MARK: - Constants
    
    private let favoritesKey = "favoriteProducts"
    private let favouritePopupDelay = 1.0
    
    // MARK: - Fetch Products
    
    func fetchProducts() {
        isLoading = true
        errorMessage = nil
        
        fetchProductsUseCase.execute { [weak self] result in
            
            DispatchQueue.main.async {
                
                guard let self = self else {
                    return
                }
                
                self.isLoading = false
                
                switch result {
                    
                case .success(let products):
                    self.products = products
                    self.searchedProducts = products
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
    // MARK: - Favorite Handling
    
    func toggleFavorite(product: Product) {
        if favoriteProducts.contains(product.id) {
            favoriteProducts.remove(product.id)
            
            favoritePopup = FavoritePopup(
                message: "Removed from Favorites",
                icon: "heart",
                color: .black
            )
        } else {
            favoriteProducts.insert(product.id)
            
            favoritePopup = FavoritePopup(
                message: "Added to Favorites",
                icon: "heart.fill",
                color: .red
            )
        }
        
        saveFavorites()
        showPopup()
    }
    
    private func showPopup() {
        showFavoritePopup = true
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + favouritePopupDelay
        ) { [weak self] in
            self?.showFavoritePopup = false
        }
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
    
    
    
    // MARK: - Search
    
    func search() {
        
        if searchText.isEmpty {
            searchedProducts = products
            return
        }
        
        searchedProducts = products.filter { product in
            product.title.localizedCaseInsensitiveContains(searchText)
            || product.category?.localizedCaseInsensitiveContains(searchText) == true
        }
    }
}
