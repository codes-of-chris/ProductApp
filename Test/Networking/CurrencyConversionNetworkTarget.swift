//
//  CurrencyConversionNetworkTarget.swift
//  Test
//
//  Created by Chris Andrews on 15/10/2022.
//

import Foundation

enum CurrencyConversionNetworkTarget: APITarget {
    
    private static let basePath = "https://api.apilayer.com/"
    
    case fetchLatestExhangeRate
    
    var base: String { CurrencyConversionNetworkTarget.basePath }
    
    var path: String {
        
        switch self {
        case .fetchLatestExhangeRate:
            
            return "currency_data"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .fetchLatestExhangeRate:
            return .get
        }
    }
    
    var parameters: APIParamEncoding? {
        
        switch self {
        case .fetchLatestExhangeRate:
            return nil
        }
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .fetchLatestExhangeRate:
            
            return nil
        }
    }
    
    var sampleData: Data {
        
        switch self {
        case .fetchLatestExhangeRate:
            return openLocal(filename: "currency_conversion")
        }
    }
    
    private func openLocal(filename: String) -> Data {

        let path = Bundle.main.path(forResource: filename, ofType: "json")!
        
        // Should only be ran with mock data when developing
        // swiftlint:disable force_try
        return try! Data(contentsOf: URL(fileURLWithPath: path))
    }

}
