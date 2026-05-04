//
//  NetworkServiceProtocol.swift
//  notes-app_ios
//
//  Created by Erick El nino on 2026/05/04.
//
import Foundation

protocol NetworkService {
    func send<R: APIRequest>(_ request: R) async throws -> R.Response
}

