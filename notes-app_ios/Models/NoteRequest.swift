//
//  NoteRequest.swift
//  notes-app_ios
//
//  Created by Erick El nino on 2026/05/05.

//
// WHY: Each API operation is its own small struct.
// This is the "concrete request" pattern — each type carries
// exactly the data it needs and nothing more.

import Foundation

// Body sent for create and update
struct NoteBody: Encodable {
    let note: String
}

// GET /api/notes
struct FetchNotesRequest: APIRequest {
    typealias Response = NotesResponse
    var path: String { APIConstants.Endpoints.notes }
    
    var method: HTTPMethod {
        return .get
    }
}

// GET /api/notes/:id
struct FetchNoteRequest: APIRequest {
    typealias Response = SingleNoteResponse
    let id: String
    var path: String { APIConstants.Endpoints.notE(id: id) }
    var method: HTTPMethod { .get }
}

// POST /api/notes
struct CreateNoteRequest: APIRequest {
    typealias Response = SingleNoteResponse
    let noteText: String
    var path: String { APIConstants.Endpoints.notes }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(NoteBody(note: noteText)) }
}

// PUT /api/notes/:id
struct UpdateNoteRequest: APIRequest {
    typealias Response = SingleNoteResponse
    let id: String
    let noteText: String
    var path: String { APIConstants.Endpoints.notE(id: id) }
    var method: HTTPMethod { .put }
    var body: Data? { try? JSONEncoder().encode(NoteBody(note: noteText)) }
}

// DELETE /api/notes/:id
struct DeleteNoteRequest: APIRequest {
    typealias Response = DeleteResponse
    let id: String
    var path: String { APIConstants.Endpoints.notE(id: id) }
    var method: HTTPMethod { .delete }
}
