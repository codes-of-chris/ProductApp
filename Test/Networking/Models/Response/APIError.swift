//
//  APIError.swift
//  Test
//
//  Created by Chris Andrews on 12/10/2022.
//

import Foundation

struct APIError: Codable {
  
    let status: Int
    let message: String
}
