import SwiftUI

struct ProductActionButtonsView: View {
    
    let product: Product
    
    @ObservedObject var productDetailsModelView: ProductDetailsModelView
    
    var body: some View {
        HStack(spacing: 20) {
            
            AddToCartButton(
                product: product,
                productDetailsModelView: productDetailsModelView
            )
            
            ShareButton()
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}
