import SwiftUI

@main
struct Product_CatalogApp: App {
    
    var body: some Scene {
        WindowGroup {
            ProductListView(
                productListModelView: ProductListModelView()
            )
        }
    }
}
