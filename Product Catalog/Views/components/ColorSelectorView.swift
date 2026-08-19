import SwiftUI

struct ColorSelectionView: View {
    
    @ObservedObject var productDetailsModelView: ProductDetailsModelView
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 20
        ) {
            
            Text("COLOR")
                .font(
                    .system(
                        size: 16,
                        weight: .bold
                    )
                )
                .tracking(2)
            
            HStack {
                ForEach(
                    productDetailsModelView.colors.indices,
                    id: \.self
                ) { color in
                    
                    ZStack {
                        
                        Circle()
                            .fill(
                                productDetailsModelView.colors[color]
                            )
                            .frame(
                                width: 40,
                                height: 40
                            )
                        
                        if productDetailsModelView.selectedColor == color {
                            
                            Circle()
                                .stroke(
                                    productDetailsModelView.colors[color],
                                    lineWidth: 4
                                )
                                .frame(
                                    width: 50,
                                    height: 50
                                )
                        }
                    }
                    .onTapGesture {
                        productDetailsModelView.selectColor(color)
                    }
                }
            }
        }
    }
}
