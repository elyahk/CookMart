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

struct ContentView: View {
    @ObservedObject var model = Model()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List(model.ingredients) { ingredient in
                    Section("Vagetables") {
                        ForEach(Array(model.ingredients.enumerated()), id: \.element.id) { index, ingredient in
                            Button {
                                model.ingredients[0].isSelected.toggle()
//                                model.ingredients.first(where: {$0 == ingredient})?.isSelected.toggle()
                            } label: {
                                HStack {
                                    Image(ingredient.imageName)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding([.trailing], 4)
                                    Text(ingredient.name)
                                        .font(.title2)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: ingredient.isSelected ? "checkmark.square.fill" : "square")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(ingredient.isSelected ? .green : .black)
                                }
                                .padding(8)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                
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
            .navigationTitle("Ingredients")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension ContentView {
    class Model: ObservableObject {
        @Published var ingredients: [Ingredient] = [
            Ingredient(name: "Apple", imageName: "apple"),
            Ingredient(name: "Onion", imageName: "onion"),
            Ingredient(name: "Carrots", imageName: "carrots"),
            Ingredient(name: "Mushroom", imageName: "mushroom"),
            Ingredient(name: "Tomato", imageName: "tomato")
        ]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
