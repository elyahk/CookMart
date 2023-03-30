//    let model = try! MobileNetV2(configuration: MLModelConfiguration())

import CoreML
import UIKit
import SwiftUI
import ComposableArchitecture

struct IngredientsView: View {
    let store: StoreOf<Ingredients>
    
    init(store: StoreOf<Ingredients>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack(alignment: .bottom) {
                List {
                    ForEach(viewStore.ingredients) { ingredient in
                        IngredientView(store: .init(
                            initialState: ingredient,
                            reducer: Ingredient()
                        ))
                    }
                }
                
                NavigationLink {
                    MealView(store: StoreOf<Meal>(initialState: Meal.mock, reducer: Meal()))
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

struct IngredientsView_Previews: PreviewProvider {
    
    static var previews: some View {
        IngredientsView(store: .init(
            initialState: Ingredients.mock,
            reducer: Ingredients()
        ))
    }
}

extension Ingredients {
    static var ingredients: IdentifiedArrayOf<Ingredient.State> = [
        Ingredient.State(name: "Apple", imageName: "apple"),
        Ingredient.State(name: "Onion", imageName: "onion"),
        Ingredient.State(name: "Carrots", imageName: "carrots"),
        Ingredient.State(name: "Mushroom", imageName: "mushroom"),
        Ingredient.State(name: "Tomato", imageName: "tomato")
    ]
    
    static var mock: Ingredients.State = .init(ingredients: ingredients)
}
