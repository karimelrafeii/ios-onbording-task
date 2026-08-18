import SwiftUI

enum FavoriteAction {
    case added
    case removed
}

final class ProductListModelView: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var searchText: String = ""
    @Published var favoriteProducts: Set<Int> = []
    @Published var showFavoritePopup = false
    @Published var favoriteAction: FavoriteAction = .added
    
    @Published var products: [Product] = []
    @Published var searchedProducts: [Product] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    
    // MARK: - Dependencies
    
    private let fetchProductsUseCase: FetchProductsUseCase
    
    
    // MARK: - Constants
    
    private let favoritesKey = "favoriteProducts"
    
    
    // MARK: - Initialization
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
        
        loadFavorites()
        fetchProducts()
    }
    
    
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
        ) { [weak self] in
            self?.showFavoritePopup = false
        }
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
