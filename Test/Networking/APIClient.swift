//
//  APIClient.swift
//  Test
//
//  Created by Chris Andrews on 12/10/2022.
//

import Foundation

public protocol APIClient {

    func request(target: APITarget, completion: @escaping (Result<Data, Error>) -> Void)
}
