import SwiftUI

struct AddToCartButton: View {
    
    let product: Product
    
    @ObservedObject var productDetailsModelView: ProductDetailsModelView
    
    var body: some View {
        Button {
            productDetailsModelView.handleCartButton(
                product: product
            )
        } label: {
            
            HStack(spacing: 20) {
                
                Image(
                    systemName:
                        productDetailsModelView.cartButtonIcon
                )
                .font(
                    .system(
                        size: 22,
                        weight: .medium
                    )
                )
                
                Text(
                    productDetailsModelView.cartButtonText
                )
                .font(
                    .system(
                        size: 22,
                        weight: .bold
                    )
                )
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .background(
                productDetailsModelView.cartButtonColor
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 20
                )
            )
        }
    }
}
