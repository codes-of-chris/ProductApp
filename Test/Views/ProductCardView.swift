//
//  ProductCardView.swift
//  Test
//
//  Created by Chris Andrews on 12/10/2022.
//

import SwiftUI

struct ProductCardView: View {
    
    @AppStorage(Constants.selectedCurrencyKey) var selectedCurrency: Currencies = .GBP
    private let product: Product

    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
                
        VStack(alignment: .center) {
                        
            AsyncImage(url: product.primaryImageMap.thumbnail.urlFromString) { phase in

                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image("empty_image_view")
                } else {
                    ProgressView()
                }
            }
                         
            Group {
                Text(product.designer.name).font(.callout)
                Text(product.name).font(.caption2).lineLimit(1)
                Text(product.price.formattedValue).font(.caption2)
                
                if let formattedCurrencyValue = product.price.formattedForUserCurrencySelection {
                    
                    Text(formattedCurrencyValue).font(.caption2)
                }
            }.foregroundColor(.black)
        }
        .cornerRadius(8)
        .frame(maxWidth: 150, maxHeight: 250)
    }
}


struct ProductView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let designer = Designer(name: "Persee")
        let price = Price(currencyIso: "GBP", value: 750.00, formattedValue: "£750.00")
        
        let thumbNailImageMap = ImageMap(url: "//assetsprx.matchesfashion.com/img/product/1501747_1_thumbnail.jpg")
        let largeImageMap = ImageMap(url: "//assetsprx.matchesfashion.com/img/product/1501747_1_thumbnail.jpg")
            
        let primaryImageMap = PrimaryImageMap(thumbnail: thumbNailImageMap, large: largeImageMap)
        
        let product = Product(code: "100202", name: "Scarf", designer: designer,
                       price: price, primaryImageMap: primaryImageMap)
        
        ProductCardView(product: product)
    }
}
