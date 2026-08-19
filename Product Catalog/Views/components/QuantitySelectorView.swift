import SwiftUI

struct QuantitySelectorView: View {
    
    @ObservedObject var productDetailsModelView: ProductDetailsModelView
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 20
        ) {
            
            Text("QUANTITY")
                .font(
                    .system(
                        size: 16,
                        weight: .bold
                    )
                )
                .tracking(2)
            
            HStack(spacing: 20) {
                
                Button {
                    productDetailsModelView.decreaseQuantity()
                } label: {
                    Text("-")
                        .font(
                            .system(
                                size: 25,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(.black)
                }
                
                Text("\(productDetailsModelView.quantity)")
                    .font(
                        .system(
                            size: 20,
                            weight: .medium
                        )
                    )
                
                Button {
                    productDetailsModelView.increaseQuantity()
                } label: {
                    Text("+")
                        .font(
                            .system(
                                size: 25,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(.black)
                }
            }
            .frame(
                width: 140,
                height: 55
            )
            .background(
                Color.gray.opacity(0.10)
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 20
                )
            )
        }
    }
}
