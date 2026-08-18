//
//  ContentView.swift
//  Product Catalog
//
//  Created by ziad dahish on 12/08/2026.
//

import SwiftUI
import Moya

struct ProductListView: View {
    
    @StateObject var productListViewModel: ProductListViewModel
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {
                    
                    // MARK: - Header
                    
                    Text("New Arrivals")
                        .fontWeight(.heavy)
                        .font(.system(size: 40))
                    
                    Text("Discover our latest collection")
                        .font(.system(size: 21))
                        .foregroundColor(.gray)
                    
                    
                    // MARK: - Search Bar
                    
                    HStack(spacing: 16) {
                        
                        Image(systemName: "magnifyingglass")
                            .padding(4)
                            .font(
                                .system(
                                    size: 22,
                                    weight: .medium
                                )
                            )
                            .foregroundColor(.gray)
                        
                        TextField(
                            "Search products...",
                            text: $productListViewModel.searchText
                        )
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                        .onChange(of: productListViewModel.searchText
                        ){
                            productListViewModel.search()
                        }
                    }
                    .padding(.horizontal, 22)
                    .frame(
                        width: 370,
                        height: 64
                    )
                    .background(
                        Color.gray.opacity(0.10)
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 22
                        )
                    )
                    .padding(.top, 30)
                    if productListViewModel.isLoading {
                        
                        ProductSkeletonView()
                        
                    }else {
                        // MARK: - Products
                        
                        ForEach(productListViewModel.searchedProducts) { product in
                            
                            ZStack(alignment: .topTrailing) {
                                
                                // MARK: Product Navigation
                                
                                NavigationLink {
                                    
                                    ProductDetailsView(
                                        product: product
                                    )
                                    
                                } label: {
                                    
                                    VStack(
                                        alignment: .leading,
                                        spacing: 5
                                    ) {
                                        CachedAsyncImage(
                                            url: product.imageURL
                                        )
                                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.25)
                                        .padding(.top)
                                        .padding(.horizontal)
                                        Text(product.category ?? "Category")
                                            .foregroundColor(.gray)
                                            .padding(.top, 10)
                                        
                                        
                                        Text(product.title)
                                            .fontWeight(.medium)
                                            .font(.system(size: 22))
                                        
                                        
                                        Text("$\(product.price.formatted(.number.precision(.fractionLength(2))))")
                                            .fontWeight(.medium)
                                            .font(.system(size: 24))
                                    }
                                }
                                .buttonStyle(.plain)
                                
                                
                                // MARK: Favorite Button
                                Button{
                                    productListViewModel.toggleFavorite(
                                        product: product
                                    )
                                    
                                    
                                } label: {
                                    
                                    ZStack {
                                        
                                        Circle()
                                            .fill(Color.white)
                                            .frame(
                                                width: 55,
                                                height: 45
                                            )
                                        
                                        Image(
                                            systemName:
                                                productListViewModel.favoriteProducts.contains(
                                                    product.id
                                                )
                                            ? "heart.fill"
                                            : "heart"
                                        )
                                        .font(
                                            .system(
                                                size: 22,
                                                weight: .medium
                                            )
                                        )
                                        .foregroundStyle(
                                            productListViewModel.favoriteProducts.contains(
                                                product.id
                                            )
                                            ? .red
                                            : .black
                                        )
                                    }
                                }
                                .padding(.top, 8)
                                .padding(.trailing, 20)
                            }
                        }
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.leading)
                .padding(.top)
            }
        }
        .overlay {
            if productListViewModel.showFavoritePopup {
                VStack(spacing: 10) {
                    Image(systemName: productListViewModel.favoritePopup?.icon ?? "")
                        .font(.system(size: 28))
                        .foregroundStyle(
                            productListViewModel.favoritePopup?.color ?? .black
                        )
                    
                    Text(
                        productListViewModel.favoritePopup?.message ?? ""
                    )
                    .font(
                        .system(
                            size: 18,
                            weight: .bold
                        )
                    )
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                .background(.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .shadow(radius: 10)
                .transition(.opacity)
            }
        }.refreshable {
            productListViewModel.fetchProducts()
        }
    }
}


#Preview {
    let fetchProductUseCase = ProductUseCaseProvider.provide()
    ProductListView(
        productListViewModel: ProductListViewModel(fetchProductsUseCase: fetchProductUseCase)
    )
}
