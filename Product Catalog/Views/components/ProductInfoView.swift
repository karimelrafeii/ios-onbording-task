import SwiftUI

struct ProductInfoView: View {
    
    let product: Product
    
    var body: some View {
        VStack(spacing: 15) {
            
            // Category + Rating
            HStack(spacing: 130) {
                
                Text(product.category ?? "")
                    .foregroundStyle(.gray)
                    .fontWeight(.medium)
                    .font(.system(size: 18))
                    .tracking(2)
                
                HStack(spacing: 4) {
                    
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    
                    Text(
                        (product.rating?.rate ?? 0.0)
                            .formatted(.number)
                    )
                    .fontWeight(.heavy)
                    
                    Text(
                        "(\(product.rating?.count ?? 0) reviews)"
                    )
                    .foregroundStyle(.gray)
                    .font(.system(size: 14))
                }
            }
            .padding(.top)
            
            // Title
            Text(product.title)
                .font(.system(size: 38))
                .fontWeight(.heavy)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            
            // Price
            Text(
                "$\(product.price.formatted(
                    .number.precision(.fractionLength(2))
                ))"
            )
            .font(.system(size: 30))
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(.horizontal)
            .fontWeight(.medium)
        }
    }
}
