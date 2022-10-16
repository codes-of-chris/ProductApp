//
//  APIParamEncoding.swift
//  Test
//
//  Created by Chris Andrews on 12/10/2022.
//

import Foundation

public enum APIParamEncoding {
    
    case url([String: String]), jsonEncodedData(Data?), multipartFormData([Data])
}
