import SwiftUI

struct ProductDetailsView: View {
    
    let product: Product
    
    @StateObject var productDetailsModelView = ProductDetailsModelView(
        cartRepository: CartRepositoryProvider.provide()
    )
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                
                ProductImageView()
                
                ProductInfoView(product: product)
                
                ProductDescriptionView(product: product)
                
                ProductOptionsView(
                    productDetailsModelView: productDetailsModelView
                )
                
                ProductActionButtonsView(
                    product: product,
                    productDetailsModelView: productDetailsModelView
                )
            }
        }
    }
}

//#Preview {
//
//    ProductDetailsView(
//        product: Product(
//            id: 1,
//            title: "Minimalist Lounge Chair",
//            description: "Minimalist chair lounge",
//            category: "Furniture",
//            price: 849.00,
//            imageURL: "https://example.com/chair.jpg",
//            rating: Rating(
//                rate: 4.9,
//                count: 128
//            )
//        )
//    )
//}
