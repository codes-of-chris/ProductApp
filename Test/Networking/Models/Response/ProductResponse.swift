//
//  Product.swift
//  Test
//
//  Created by Chris Andrews on 12/10/2022.
//

import Foundation
import SwiftUI

struct ProductResponse: Codable {
    
    let results: [Product]
}

struct Product: Identifiable, Codable {
    
    var id: String { code } // Identifiable
    let code: String
    let name: String
    let designer: Designer
    let price: Price
    let primaryImageMap: PrimaryImageMap
}

struct Designer: Codable {
    
    let name: String
}

struct Price: Codable {
        
    let currencyIso: String
    let value: Double
    let formattedValue: String
    var formattedForUserCurrencySelection: String? {
        
        let helper = CurrencyHelper.shared
        let userSelectedCurrency = helper.selectedCurrency
        guard let rate = helper
            .fetchCurrencyRateFor(baseCurrencyIso: currencyIso,
                                  userSelectedCurrency: userSelectedCurrency) else { return nil }
        let formattedValue = helper.formattedForCurrency(currencyRate: rate,
                                                         userSelectedCurrency: userSelectedCurrency, baseValue: value)
        return formattedValue
    }
}

struct PrimaryImageMap: Codable {
    
    let thumbnail: ImageMap
    let large: ImageMap
}

struct ImageMap: Codable {
    let url: String
    var urlFromString: URL? { return URL(string: "https:\(url)") }
}
