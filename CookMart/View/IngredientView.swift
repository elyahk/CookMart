import SwiftUI
import ComposableArchitecture

struct IngredientView: View {
    let store: StoreOf<Ingredient>
    
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
                            .frame(width: 30, height: 30)
                            .foregroundColor(viewStore.isSelected ? .green : .black)
                    }
                    .padding(8)
                }
            }
            .foregroundColor(viewStore.isSelected ? .gray : nil)
        }
    }
}


struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(store: .init(
            initialState: .init(name: "Apple", imageName: "apple"),
            reducer: Ingredient()
        ))
    }
}
