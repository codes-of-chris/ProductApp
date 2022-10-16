//
//  FasionApiClient.swift
//  Test
//
//  Created by Chris Andrews on 12/10/2022.
//

import Foundation

public class FashionApiClient: APIClient {

    public let session: URLSession

    public init(session: URLSession = URLSession.shared) {

        let config = session.configuration
        config.timeoutIntervalForRequest = 10
        self.session = URLSession(configuration: config)
    }

    // MARK: APIClient
    public func request(target: APITarget, completion: @escaping (Result<Data, Error>) -> Void) {

        var components = URLComponents(string: target.base + target.path)!
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = target.method.rawValue
        target.headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }

        if let encoding = target.parameters {
            
            switch encoding {
                
            case .multipartFormData(let multipartData):
                multipartData.forEach { request.httpBody?.append($0) }
            case .jsonEncodedData(let encodable):
                request.httpBody = encodable
            case .url(let params):
                components.queryItems = params.map { (key, value) in URLQueryItem(name: key, value: value) }
            }
        }

        session.dataTask(with: request) { (responseData, _, responseError) in
            
            if let responseData = responseData {
                completion(.success(responseData))
            } else if let responseError = responseError {
                completion(.failure(responseError))
            }
        }.resume()
    }
}
