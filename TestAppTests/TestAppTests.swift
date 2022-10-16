//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by Chris Andrews on 15/10/2022.
//

import XCTest
@testable import Test

final class TestAppTests: XCTestCase {
    
    private var currencyHelper: CurrencyHelper!
    
    override func setUpWithError() throws {
        
        currencyHelper = CurrencyHelper(currencyAPIClient: MockAPIClient())
    }

    override func tearDownWithError() throws {}

    func testCurrencyHelper_fetchCurrencyRate_productSourceCurrencyShouldBeValid() throws {
        
        let invalidSourceCurrencyISO = currencyHelper.fetchCurrencyRateFor(baseCurrencyIso: "GBO", userSelectedCurrency: .USD)
        let emptySourceCurrencyISO = currencyHelper.fetchCurrencyRateFor(baseCurrencyIso: "", userSelectedCurrency: .USD)
        let productSourceSameAsUserSeleced = currencyHelper.fetchCurrencyRateFor(baseCurrencyIso: "USD", userSelectedCurrency: .USD)
        
        XCTAssertNil(invalidSourceCurrencyISO, "Product Source Currency is not available")
        XCTAssertNil(emptySourceCurrencyISO, "Product Source Currency is not available")
        XCTAssertNil(productSourceSameAsUserSeleced, "Product Source cannot be same as user selected currency. (No conversion needs to be made)")
    }
    
    func testCurrencyHelper_formattedForCurrency_formatAndValueShouldBeCorrect() throws {
        
        let productPrice = Price(currencyIso: "GBP", value: 100.00, formattedValue: "£100.00")
        
        let usdRate = 1.5
        let eurRate = 1.5
        let invalidNegativeEurRate = -0.1
        let emptyConversionRate = 0.0

        let usdConvertedValue = currencyHelper.formattedForCurrency(currencyRate: usdRate, userSelectedCurrency: .USD, baseValue: productPrice.value)
        let eurConvertedValue = currencyHelper.formattedForCurrency(currencyRate: eurRate, userSelectedCurrency: .EUR, baseValue: productPrice.value)
        let invalidNegativeEurConvertedValue = currencyHelper
            .formattedForCurrency(currencyRate: invalidNegativeEurRate, userSelectedCurrency: .EUR, baseValue: productPrice.value)
        let emptyNegativeEurConvertedValue = currencyHelper
            .formattedForCurrency(currencyRate: emptyConversionRate, userSelectedCurrency: .EUR, baseValue: productPrice.value)
        
        XCTAssertEqual(usdConvertedValue, "$150.00")
        XCTAssertEqual(eurConvertedValue, "€150.00")
        XCTAssertNil(invalidNegativeEurConvertedValue, "Conversion rate must be a positive number")
        XCTAssertNil(emptyNegativeEurConvertedValue, "Conversion rate must be greater than 0")
    }
    
    func testCurrencyHelper_fetchCurrency_mockDataShouldMatchCurrentModel() throws {
        
        currencyHelper.currencyAPIClient.request(target: CurrencyConversionNetworkTarget.fetchLatestExhangeRate) { result in
            
            switch result {
            case .success(let successData):

                XCTAssertNil(try? JSONDecoder().decode(CurrencyConversionResponse.self, from: successData),
                             "Failed to parse CurrencyConversionResponse from mock api")
            case .failure(let error):
                XCTFail("Failure \(error) when fetching mock data")
            }
        }
    }
}
