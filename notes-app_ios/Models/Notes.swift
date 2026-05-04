//
//  Notes.swift
//  notes-app_ios
//
//  Created by Erick El nino on 2026/05/05.
//

import Foundation

struct Note: Codable, Identifiable, Equatable {
    let id: String
    let note: String
    let createdAt: Date
    let updatedAt: Date
    
    // Map JSON keys "_id", "createdAt", "updatedAt" to Swift names.
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case note
        case createdAt
        case updatedAt
    }
}

// --- API response wrappers ---

struct NotesResponse: Decodable {
    let success: Bool
    let count: Int
    let data: [Note]
}

struct SingleNoteResponse: Decodable {
    let success: Bool
    let data: Note
}

struct DeleteResponse: Decodable {
    let success: Bool
    let message: String
}
