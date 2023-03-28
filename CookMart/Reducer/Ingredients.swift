import Foundation
import ComposableArchitecture

struct Ingredients: ReducerProtocol {
    struct State: Equatable {
        var ingredients: IdentifiedArrayOf<Ingredient.State> = []
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

