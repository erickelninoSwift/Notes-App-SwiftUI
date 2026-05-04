//
//  NetworkService.swift
//  notes-app_ios
//
//  Created by Erick El nino on 2026/05/04.
//

import Foundation

final class NetworkServiceImpl: NetworkService {
    
    private let session: URLSession
    
    // Dependency injection: pass in a custom session for testing,
    // or use the shared session in production.
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send<R: APIRequest>(_ request: R) async throws -> R.Response {
        let urlRequest: URLRequest
        do {
            urlRequest = try request.urlRequest()
        } catch {
            throw NetworkError.invalidURL
        }
        
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(for: urlRequest)
        } catch let urlError as URLError where urlError.code == .notConnectedToInternet {
            throw NetworkError.offline
        } catch {
            throw NetworkError.requestFailed(error)
        }
        
        // Check the HTTP status code.
        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            throw NetworkError.serverError(http.statusCode)
        }
        
        guard !data.isEmpty else { throw NetworkError.noData }
        
        do {
            let decoder = JSONDecoder()
            // Our API returns ISO 8601 dates.
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(R.Response.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
