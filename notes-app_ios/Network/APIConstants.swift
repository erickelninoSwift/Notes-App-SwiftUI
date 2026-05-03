//
//  Untitled.swift
//  notes-app_ios
//
//  Created by Erick El nino on 2026/05/02.
//

import Foundation

enum APIConstants {
     static let baseUrl = "http://localhost:3000/api"
      enum Endpoints {
          
          static let notes = "/notes"
          static func notE(id: String) -> String { "notes/\(id)"}
         
    }
}
