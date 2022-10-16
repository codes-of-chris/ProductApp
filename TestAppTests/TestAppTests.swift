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
    
    func testCurrencyHelper_formattedForCurrency_formatShouldBeCorrect() throws {
        
        let productPrice = Price(currencyIso: "GBP", value: 100.00, formattedValue: "£100.00")
        
        guard let usdRate = currencyHelper.fetchCurrencyRateFor(baseCurrencyIso: productPrice.currencyIso,
                                                             userSelectedCurrency: .USD) else {
            XCTFail("Expected to receive valid conversion rate")
            return
        }
        
        guard let eurRate = currencyHelper.fetchCurrencyRateFor(baseCurrencyIso: productPrice.currencyIso,
                                                                userSelectedCurrency: .EUR) else {
            XCTFail("Expected to receive valid conversion rate")
            return
        }

        let usdConvertedValue = currencyHelper.formattedForCurrency(curencyRate: usdRate, userSelectedCurrency: .USD, baseValue: productPrice.value)
        let eurConvertedValue = currencyHelper.formattedForCurrency(curencyRate: eurRate, userSelectedCurrency: .EUR, baseValue: productPrice.value)
        XCTAssertEqual(usdConvertedValue, "$150.00")
        XCTAssertEqual(eurConvertedValue, "€150.00")
    }
}
