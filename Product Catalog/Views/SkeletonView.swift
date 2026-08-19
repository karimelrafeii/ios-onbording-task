import SwiftUI

struct ProductSkeletonView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 370, height: 370)
                .shimmer()
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 100, height: 18)
                .shimmer()
                .padding(.top, 10)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 300, height: 25)
                .shimmer()
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 100, height: 28)
                .shimmer()
        }
    }
}
