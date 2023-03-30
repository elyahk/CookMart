//
//  MealView.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 29/03/23.
//

import SwiftUI
import ComposableArchitecture

struct Meal: ReducerProtocol {
    struct State: Equatable {
        var title: String
        var coverImage: UIImage
        var description: String
        var quickInfo: QuickInfo
        var ingredients: Ingredients.State
        var steps: [CookStep]
    }
    
    struct CookStep: Equatable {
        var description: String
    }
    
    struct QuickInfo: Equatable {
        var callories: String
        var preparationTime: String
        var difficulty: Difficulty
    }
    
    enum Difficulty: String {
        case easy
        case medium
        case difficult
    }
    
    enum Action: Equatable {
        case startButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .startButtonTapped:
            return .none
        }
    }
}

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

    enum ScrollId: Hashable {
        case engridients
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

struct CookingStepView: View {
    @State var steps: [String]
    
    init(steps: [String]) {
        self.steps = steps
    }

    var body: some View {
            VStack(alignment: .leading) {
                ForEach(Range(1...steps.count)) { id in
                    VStack(alignment: .leading) {
                        Text("\(id). Step")
                            .font(.title3)
                            .bold()
                            .padding([.leading])
                            .padding([.bottom], 0.5)
                        HStack {
                            Text(steps[id-1])
                        }
                        .padding([.leading])
                    }
                    .padding([.top], 4)
                }
            }
        
    }
}

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





