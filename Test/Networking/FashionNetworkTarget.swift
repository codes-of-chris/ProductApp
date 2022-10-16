//
//  FashionNetworkTarget.swift
//  Test
//
//  Created by Chris Andrews on 12/10/2022.
//

import Foundation

enum FashionNetworkTarget: APITarget {
    
    private static let basePath = "https://www.matchesfashion.com/"
    
    case fetchWomensClothes
    
    var base: String { FashionNetworkTarget.basePath }
    
    var path: String {
        
        switch self {
        case .fetchWomensClothes:
            
            return "womens/shop"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .fetchWomensClothes:
            return .get
        }
    }
    
    var parameters: APIParamEncoding? {
        
        switch self {
        case .fetchWomensClothes:
            return .url(["format": "json"])
        }
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .fetchWomensClothes:
            
            return nil
        }
    }
    
    var sampleData: Data {
        
        switch self {
        case .fetchWomensClothes:
            return openLocal(filename: "womens_products")
        }
    }
    
    private func openLocal(filename: String) -> Data {

        let path = Bundle.main.path(forResource: filename, ofType: "json")!
        
        // Should only be ran with mock data when developing
        // swiftlint:disable force_try
        return try! Data(contentsOf: URL(fileURLWithPath: path))
    }
}
