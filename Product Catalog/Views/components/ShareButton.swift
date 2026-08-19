import SwiftUI

struct ShareButton: View {
    
    var body: some View {
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
}
