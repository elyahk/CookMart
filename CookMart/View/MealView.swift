//
//  MealView.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 29/03/23.
//

import SwiftUI
import ComposableArchitecture

struct MealView: View {
    enum PickerState {
        case engridient
        case process
    }
    @State var pickerState: PickerState = .process
    let store: StoreOf<Meal>
    
    init(store: StoreOf<Meal>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack(alignment: .bottom) {
                ScrollView {
                    ScrollViewReader { value in
                        VStack(alignment: .leading) {
                            Image(uiImage: viewStore.coverImage)
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                            
                            Text(viewStore.title)
                                .font(.title)
                                .bold()
                                .padding()
                            
                            QuickInfoView()
                            .frame(maxWidth: .infinity)
                            
                            Text(viewStore.description)
                                .font(.body)
                                .padding()
                            
                            Text("Cooking")
                                .font(.title)
                                .bold()
                                .padding([.leading, .trailing])
                            
                            Picker("What is your favorite color?", selection: $pickerState) {
                                Text("Process").tag(PickerState.process)
                                Text("Engridients").tag(PickerState.engridient)
                            }
                            .pickerStyle(.segmented)
                            .padding([.leading, .trailing])
                            
                            CookingStepView(steps: viewStore.steps.map { $0.description })
                        }
                    }
                }
                
                Button("Start") { }
                    .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 45.0)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10.0)
                    .padding()
            }
        }
        .ignoresSafeArea()
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView(store: .init(
            initialState: Meal.mock,
            reducer: Meal()
        ))
    }
}

extension Meal {
    static var mock = Meal.State(
        title: "Pasta alla Norma",
        coverImage: UIImage(named: "pasta-alla-norma")!,
        description: "Pasta alla Norma is a classic Sicilian dish made with rigatoni pasta and a flavorful tomato sauce, spiced with garlic and red pepper flakes. The sauce is combined with cooked potatoes and meat, and finished with fresh parsley and Parmesan cheese. It's a comforting and easy-to-make dish that's perfect for using up leftovers.",
        quickInfo: .init(callories: "500 kkal", preparationTime: "25 mins", difficulty: .easy),
        ingredients: .init(ingredients: [
            .init(name: "", imageName: "", isSelected: false),
            .init()
        ]),
        steps: [
            .init(description: "Cook the pasta according to package instructions."),
            .init(description: "In a large skillet, heat the olive oil over medium heat."),
            .init(description: "Add the onion and garlic and cook until softened, about 5 minutes."),
            .init(description: "Add the diced tomatoes, red pepper flakes, salt, and black pepper. Cook for 10-15 minutes until the sauce has thickened."),
            .init(description: "Add the cooked meat, potatoes, and tomatoes to the skillet and stir to combine."),
            .init(description: "Drain the pasta and add it to the skillet. Toss to coat the pasta with the sauce."),
            .init(description: "Top with chopped parsley and grated Parmesan cheese.")
        ]
    )
}





