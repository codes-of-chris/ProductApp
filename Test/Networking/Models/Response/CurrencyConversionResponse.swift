//
//  Currency.swift
//  Test
//
//  Created by Chris Andrews on 15/10/2022.
//

import Foundation

struct CurrencyConversionResponse: Codable {
    
    let quotes: Quotes
    let source: Currencies
    let success: Bool
    let timestamp: Int
}

struct Quotes: Codable {
 
    let GBPEUR: Double
    let GBPUSD: Double
}
