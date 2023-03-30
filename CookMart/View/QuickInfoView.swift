//
//  File.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import SwiftUI

struct QuickInfoView: View {
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "flame.fill")
                    .padding([.bottom], 4)
                Text("200 kkal")
                    .font(.caption)
            }
            .padding([.leading], 40)
            Spacer()
            VStack {
                Image(systemName: "clock.badge.checkmark")
                    .padding([.bottom], 4)
                Text("25 mins")
                    .font(.caption)
            }
            Spacer()
            VStack {
                Image(systemName: "graduationcap.fill")
                    .padding([.bottom], 4)
                Text("easy")
                    .font(.caption)
            }
            .padding([.trailing], 40)
        }
    }
}
