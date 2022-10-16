//
//  CurrencyHelper.swift
//  Test
//
//  Created by Chris Andrews on 15/10/2022.
//

import Foundation
import SwiftUI

class CurrencyHelper {
    
    @AppStorage(Constants.selectedCurrencyKey) var selectedCurrency: Currencies = .GBP
    static let shared = CurrencyHelper(currencyAPIClient: MockAPIClient())
    let currencyAPIClient: APIClient
    
    init(currencyAPIClient: APIClient) { self.currencyAPIClient = currencyAPIClient }
    
    func fetchCurrencyRateFor(baseCurrencyIso: String, userSelectedCurrency: Currencies) -> Double? {
        
        // Check source currency is valid
        guard let prouctSourceCurrency = Currencies(rawValue: baseCurrencyIso) else { return nil }
        
        // Check we are not doing a like-for-like conversion
        guard prouctSourceCurrency != userSelectedCurrency else { return nil }
        
        guard let latestRates = fetchCurrencyConversionResponseFromUserDefaults() else { return nil }
        
        switch userSelectedCurrency {
        case .GBP:
            return nil
        case .EUR:
            return latestRates.quotes.GBPEUR
        case .USD:
            return latestRates.quotes.GBPUSD
        }
    }
    
    func formattedForCurrency(currencyRate: Double, userSelectedCurrency: Currencies, baseValue: Double) -> String? {

        guard currencyRate > 0.0 else { return nil }
        let convertedValue = currencyRate * baseValue
        return convertedValue.formatted(.currency(code: userSelectedCurrency.rawValue))
    }
    
    func fetchLatestCurrencyRates(completion: @escaping (Result<CurrencyConversionResponse, Error>) -> Void) {
        
        currencyAPIClient.request(target: CurrencyConversionNetworkTarget.fetchLatestExhangeRate) { result in

            switch result {
            case .success(let success):

                do {
                    
                    let currencyConversionResponse = try JSONDecoder()
                        .decode(CurrencyConversionResponse.self, from: success)
                    
                    completion(.success(currencyConversionResponse))
                } catch let error {
                    completion(.failure(error))
                }

            case .failure(let failure):
                
                completion(.failure(failure))
            }
        }
    }
    
    func saveCurrencyConversionResponse(response: CurrencyConversionResponse) {

        guard let encoded = try? JSONEncoder().encode(response) else { return }
        Constants.defaults.set(encoded, forKey: Constants.conversionUserDefaultsKey)
    }
    
    func fetchCurrencyConversionResponseFromUserDefaults() -> CurrencyConversionResponse? {
        
        guard let currencyConversionResponse = Constants.defaults
            .object(forKey: Constants.conversionUserDefaultsKey) as? Data,
              let response = try? JSONDecoder().decode(CurrencyConversionResponse.self,
                                                       from: currencyConversionResponse) else { return nil }
        
        return response
    }
    
    func resetCurrencies() {
        
        Constants.defaults.removeObject(forKey: Constants.conversionUserDefaultsKey)
    }
}
