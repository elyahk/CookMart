//
//  MainView.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    IngredientsView(store: StoreOf<Ingredients>.init(
                        initialState: Ingredients.mock,
                        reducer: Ingredients()
                    ))
                } label: {
                    Text("Cooking →")
                        .font(.title)
                        .foregroundColor(.yellow)
                }
                .padding()
                .background {
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(15)
                }
                
                NavigationLink {
                    ConcurencyTest()
                } label: {
                    Text("Concurrency →")
                        .font(.title)
                        .foregroundColor(.yellow)
                }
                .padding()
                .background {
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(15)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
