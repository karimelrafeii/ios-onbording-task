import SwiftUI

struct ProductDescriptionView: View {
    
    let product: Product
    
    var body: some View {
        VStack(spacing: 10) {
            
            Text("DESCRIPTION")
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.horizontal)
                .fontWeight(.heavy)
                .tracking(2)
            
            Text(product.description)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.horizontal)
                .foregroundStyle(.gray)
        }
    }
}
