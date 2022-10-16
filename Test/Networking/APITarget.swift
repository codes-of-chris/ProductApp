//
//  APITarget.swift
//  Test
//
//  Created by Chris Andrews on 12/10/2022.
//

import Foundation

public protocol APITarget {

    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: APIParamEncoding? { get }
    var headers: [String: String]? { get }
    var sampleData: Data { get }
}
