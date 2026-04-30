//
//  Home.swift
//  notes-app_ios
//
//  Created by Erick El nino on 2026/05/01.
//

import Foundation
import SwiftUI


struct Home: View {
    var body: some View {
         
        ForEach(0..<10) { data in
            Text("Erick : number: \(data)")
        }
    }
}
#Preview {
    Home()
}

