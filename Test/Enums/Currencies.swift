//
//  Currencies.swift
//  Test
//
//  Created by Chris Andrews on 15/10/2022.
//

import Foundation

enum Currencies: String, Identifiable, CaseIterable, Codable {
    
    var id: UUID { UUID() } //Identifiable
    case GBP = "GBP", EUR = "EUR", USD = "USD"
    
    var stringDescription: String {
        
        switch self {
        case .GBP:
            return "Pounds"
        case .EUR:
            return "Euros"
        case .USD:
            return "Dollars"
        }
    }
    
    var shortSymbol: String {
        switch self {
        case .GBP:
            return "£"
        case .EUR:
            return "€"
        case .USD:
            return "$"
        }
    }
}
