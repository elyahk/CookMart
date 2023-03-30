//
//  Meal.swift
//  CookMart
//
//  Created by Eldorbek Nusratov on 30/03/23.
//

import Foundation
import ComposableArchitecture
import UIKit

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

