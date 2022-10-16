//
//  ProductViewModel.swift
//  Test
//
//  Created by Chris Andrews on 12/10/2022.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    
    @AppStorage(Constants.selectedCurrencyKey) var selectedCurrency: Currencies = .GBP
    @Published var items: [Product]?
    private let fashionAPIClient: APIClient
    private let currencyConversionAPICLient: APIClient

    init(fashionAPIClient: APIClient, currencyConversionAPIClient: APIClient) {
        
        self.fashionAPIClient = fashionAPIClient
        self.currencyConversionAPICLient = currencyConversionAPIClient
    }
    
    func fetchWomensProducts() {
        
        fashionAPIClient.request(target: FashionNetworkTarget.fetchWomensClothes) { [weak self] result in
            
            switch result {
            case .success(let success):
                guard let modelResponse = try? JSONDecoder().decode(ProductResponse.self, from: success) else { return }
                DispatchQueue.main.async { self?.items = modelResponse.results }
            case .failure(let failure):
                print("Web Request Error: \(String(describing: failure))")
            }
        }
    }
    
    func fetchHomePageContent() {
        
        CurrencyHelper.shared.fetchLatestCurrencyRates { [weak self] latestCurrencyRateResponse in
            
            switch latestCurrencyRateResponse {
            case .success(let success):
                CurrencyHelper.shared.saveCurrencyConversionResponse(response: success)
                self?.fetchWomensProducts()
            case .failure(let failure):
                print("Error. No conversions available \(failure)")
            }
        }
    }
}
