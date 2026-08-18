import SwiftUI

struct ProductDetailsView: View {

    let product: Product

    @StateObject var productDetailsModelView =
        ProductDetailsModelView()


    var body: some View {
        ScrollView{
            VStack(spacing: 15) {
                
                // MARK: - Product Image
                
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, -100)
                
                
                // MARK: - Category + Rating
                
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
                
                
                // MARK: - Title
                
                Text(product.title)
                    .font(.system(size: 38))
                    .fontWeight(.heavy)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                
                // MARK: - Price
                
                Text("$\(product.price.formatted(.number.precision(.fractionLength(2))))")
                    .font(.system(size: 30))
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .padding(.horizontal)
                    .fontWeight(.medium)
                
                
                // MARK: - Description
                
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
                
                
                // MARK: - Color + Quantity
                
                HStack {
                    
                    // MARK: Color
                    
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
                                    
                                    productDetailsModelView
                                        .selectColor(color)
                                }
                            }
                        }
                    }
                    
                    
                    Spacer()
                    
                    
                    // MARK: Quantity
                    
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
                                
                                productDetailsModelView
                                    .decreaseQuantity()
                                
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
                            
                            
                            Text(
                                "\(productDetailsModelView.quantity)"
                            )
                            .font(
                                .system(
                                    size: 20,
                                    weight: .medium
                                )
                            )
                            
                            
                            Button {
                                
                                productDetailsModelView
                                    .increaseQuantity()
                                
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
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    
                    Button {
                        
                        if productDetailsModelView.isAddedToCart {
                            
                            productDetailsModelView.removeFromCart(
                                product: product
                            )
                            
                        } else {
                            
                            productDetailsModelView.addToCart(
                                product: product
                            )
                        }
                        
                    } label: {
                        
                        HStack(spacing: 20) {
                            
                            Image(
                                systemName:
                                    productDetailsModelView.isAddedToCart
                                ? "checkmark"
                                : "cart.fill"
                            )
                            .font(
                                .system(
                                    size: 22,
                                    weight: .medium
                                )
                            )
                            
                            Text(
                                productDetailsModelView.isAddedToCart
                                ? "Added to Cart"
                                : "Add to Cart"
                            )
                            .font(
                                .system(
                                    size: 22,
                                    weight: .bold
                                )
                            )
                        }
                        .foregroundStyle(.white)
                        .frame(
                            maxWidth: .infinity
                        )
                        .frame(height: 70)
                        .background(
                            productDetailsModelView.isAddedToCart
                            ? Color.gray
                            : Color.black
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 20
                            )
                        )
                    }
                    
                    
                    // Share button
                    
                    Button {
                        
                        
                        
                    } label: {
                        
                        Image(systemName: "square.and.arrow.up")
                            .font(
                                .system(
                                    size: 24,
                                    weight: .medium
                                )
                            )
                            .foregroundStyle(.black)
                            .frame(
                                width: 60,
                                height: 65
                            )
                            .background(.white)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 10
                                )
                            )
                            .overlay {
                                RoundedRectangle(
                                    cornerRadius: 20
                                )
                                .stroke(
                                    Color.gray.opacity(0.15),
                                    lineWidth: 3
                                )
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
        }
    }
}

#Preview {

    ProductDetailsView(
        product: Product(
            id: 1,
            title: "Minimalist Lounge Chair",
            description: "Minimalist chair lounge",
            category: "Furniture",
            price: 849.00,
            imageURL: "https://example.com/chair.jpg",
            rating: Rating(
                rate: 4.9,
                count: 128
            )
        )
    )
}
