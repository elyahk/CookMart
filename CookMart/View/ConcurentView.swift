//
//  File.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import Foundation
import SwiftUI

struct ConcurentView: View {
    @ObservedObject var model: ConcurentModel
    
    init(model: ConcurentModel) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            Picker("What is your favorite color?", selection: $model.type) {
                Text("Parallel").tag(ConcurentType.parallel)
                Text("Concurrent").tag(ConcurentType.concurent)
            }
            .pickerStyle(.segmented)
            .padding()
            List {
                Section {
                    CatView(cat: model.cat1)
                        .padding()
                    CatView(cat: model.cat2)
                        .padding()
                } header: {
                    Text("Cats")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black)
                }
                
                Section {
                    ActivityView(activity: model.activity1)
                        .padding()
                    ActivityView(activity: model.activity2)
                        .padding()
                } header: {
                    Text("Activities")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .onAppear {
                Task {
                    do {
                        try await model.start()
                    }
                }
            }
        }
    }
}
