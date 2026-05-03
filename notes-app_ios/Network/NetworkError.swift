//
//  NetworkError.swift
//  notes-app_ios
//
//  Created by Erick El nino on 2026/05/03.
//
import Foundation

enum NetworkError: LocalizedError {
    
    case invalidURL
    case noData
    case decodingFailed
    case serverError(Int)
    case requestFailed(Error)
    case offline
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .noData:
            return "The server returned no data."
        case .decodingFailed:
            return "Failed to decode the server response."
        case .serverError(let code):
            return "Server error (status \(code))."
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .offline:
            return "You appear to be offline. Showing cached notes."
        }
    }
}
