//
//  ContentView.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 23/03/23.
//
//    let model = try! MobileNetV2(configuration: MLModelConfiguration())

import CoreML
import UIKit
import SwiftUI
import ComposableArchitecture

struct Ingredient1: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let id: UUID = UUID()
        var name: String = ""
        var imageName: String = ""
        var isSelected: Bool = false
    }
    
    enum Action: Equatable {
        case checkBoxToggled
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .checkBoxToggled:
            state.isSelected.toggle()
            return .none
        }
    }
}

struct IngredientView: View {
    let store: StoreOf<Ingredient1>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Button {
                    viewStore.send(.checkBoxToggled)
                } label: {
                    HStack {
                        Image(viewStore.imageName)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding([.trailing], 4)
                        Text(viewStore.name)
                            .font(.title2)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: viewStore.isSelected ? "checkmark.square" : "square")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(viewStore.isSelected ? .green : .black)
                    }
                    .padding(8)
                }
            }
            .foregroundColor(viewStore.isSelected ? .gray : nil)
        }
    }
}


class Ingredient: Identifiable, Equatable {
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var name: String = ""
    var imageName: String = ""
    var isSelected: Bool = false
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}


struct Ingredients: ReducerProtocol {
    struct State: Equatable {
        var ingredients: IdentifiedArrayOf<Ingredient1.State> = []
    }
    
    enum Action: Equatable {
        case addTodoButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .addTodoButtonTapped:
            return .none
        }
    }
}

struct ContentView1: View {
    let store: StoreOf<Ingredients>

      init(store: StoreOf<Ingredients>) {
        self.store = store
      }

    
    var body: some View {
        NavigationView {
            WithViewStore(store, observe: { $0 }) { viewStore in
                ZStack(alignment: .bottom) {
                    List {
                        ForEach(viewStore.ingredients) { ingredient in
                            IngredientView(store: .init(
                                initialState: ingredient,
                                reducer: Ingredient1()
                            ))
                        }
                    }
                    
                    Button {
                    } label: {
                        Text("Start Cook →")
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
            .navigationTitle("Ingredients")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView1_Previews: PreviewProvider {
    static var ingredients: IdentifiedArrayOf<Ingredient1.State> = [
        Ingredient1.State(name: "Apple", imageName: "apple"),
        Ingredient1.State(name: "Onion", imageName: "onion"),
        Ingredient1.State(name: "Carrots", imageName: "carrots"),
        Ingredient1.State(name: "Mushroom", imageName: "mushroom"),
        Ingredient1.State(name: "Tomato", imageName: "tomato")
    ]
    
    static var previews: some View {
        ContentView1(store: .init(
            initialState: .init(ingredients: ingredients),
            reducer: Ingredients()
        ))
    }
}
