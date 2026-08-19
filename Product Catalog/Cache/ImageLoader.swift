import UIKit

final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    private let url: String
    
    init(url: String) {
        self.url = url
    }
    
    func load() {
        
        if let cachedImage = ImageCache.shared.image(for: url) {
            self.image = cachedImage
            return
        }
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
            
            guard
                let data,
                let image = UIImage(data: data),
                error == nil
            else {
                return
            }
            
            ImageCache.shared.insert(
                image,
                for: self?.url ?? ""
            )
            
            DispatchQueue.main.async {
                self?.image = image
            }
            
        }.resume()
    }
}
