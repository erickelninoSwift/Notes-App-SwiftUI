//
//  APIRequestProtocol.swift
//  notes-app_ios
//
//  Created by Erick El nino on 2026/05/03.

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    
    var path: String          { get }
    var method: HTTPMethod    { get }
    var body: Data?           { get }
    var headers: [String: String] { get }
}

// Default implementations so conforming types only override what they need.
extension APIRequest {
    var body: Data? { nil }
    var headers: [String: String] { ["Content-Type": "application/json"] }
    
    // Builds the full URLRequest from the protocol properties.
    func urlRequest() throws -> URLRequest {
        guard let url = URL(string: APIConstants.baseUrl + path) else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
}
