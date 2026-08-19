import SwiftUI

struct ProductOptionsView: View {
    
    @ObservedObject var productDetailsModelView: ProductDetailsModelView
    
    var body: some View {
        HStack {
            
            ColorSelectionView(
                productDetailsModelView: productDetailsModelView
            )
            
            Spacer()
            
            QuantitySelectorView(
                productDetailsModelView: productDetailsModelView
            )
        }
        .padding(.horizontal)
    }
}   
