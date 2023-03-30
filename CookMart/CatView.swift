//
//  File.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import Foundation
import SwiftUI

struct CatView: View {
    @ObservedObject var cat: Cat
    
    init(cat: Cat) {
        self.cat = cat
    }
    
    var body: some View {
        HStack {
            Image("cat")
                .resizable()
                .frame(width: 30, height: 30)
            VStack(alignment: .leading) {
                HStack {
                    Text("Fun fact:")
                        .bold()
                    Spacer()
                    Text(!cat.fact.contains("Loading") ? "✅" : "...")
                        .font(.title3)
                }
                Text(cat.fact)
                    .lineLimit(3)
            }
        }
    }
}

