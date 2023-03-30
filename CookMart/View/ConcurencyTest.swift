//
//  ConcurencyTest.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 28/03/23.
//

import SwiftUI

struct ConcurencyTest: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Parallel") {
                    ConcurentView(model: .init())
                }
                .padding()
                
                NavigationLink("Concurent") {
                    ConcurentView(model: .init())
                }
                .padding()
            }
        }
    }
}

struct ConcurencyTest_Previews: PreviewProvider {
    static var previews: some View {
        ConcurencyTest()
        ConcurentView(model: .init())
    }
}
