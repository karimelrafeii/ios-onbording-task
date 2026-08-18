import SwiftUI
import UIKit

@main
struct Product_CatalogApp: App {

    var body: some Scene {
        WindowGroup {
            ProductListView(
                productListModelView: ProductListModelView()
  //              onProductTap: { [weak self] product in
//                    self?.showProductDetails(product: product)
 //               }
            )
        }
    }
}

