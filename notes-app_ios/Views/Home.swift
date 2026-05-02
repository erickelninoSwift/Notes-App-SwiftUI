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
         
        NavigationView {
            //
            List {
                ForEach(0..<10) { data in
                    Text("Erick : number: \(data + 1)")
                        .padding()
                
                }
            }
            .navigationTitle("Notes")
            .navigationBarItems(trailing: Button(action: {
                print("We dont really care")
            }, label: {
                Text("+")
            }))
    

          
        }.padding(5)
         
    }
    // button
}
#Preview {
    Home()
}

