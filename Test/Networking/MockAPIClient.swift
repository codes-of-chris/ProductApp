//
//  MockFashionAPIClient.swift
//  Test
//
//  Created by Chris Andrews on 15/10/2022.
//

import Foundation

class MockAPIClient: APIClient {
    
    func request(target: APITarget,
                 completion: @escaping (Result<Data, Error>) -> Void) { completion(.success(target.sampleData)) }
}
