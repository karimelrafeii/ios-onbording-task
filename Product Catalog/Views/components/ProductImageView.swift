import SwiftUI

struct ProductImageView: View {
    
    var body: some View {
        Image("Image")
            .resizable()
            .scaledToFit()
            .padding(.top, -100)
    }
}
