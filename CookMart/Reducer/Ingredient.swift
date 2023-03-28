import Foundation
import ComposableArchitecture

struct Ingredient: ReducerProtocol {
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

