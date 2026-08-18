import SwiftUI

struct CachedAsyncImage: View {
    
    @StateObject private var imageLoader: ImageLoader
    
    init(url: String) {
        _imageLoader = StateObject(
            wrappedValue: ImageLoader(url: url)
        )
    }
    
    var body: some View {
        
        Group {
            
            if let image = imageLoader.image {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                
            } else {
                
                ProgressView()
            }
        }
        .onAppear {
            imageLoader.load()
        }
    }
}
