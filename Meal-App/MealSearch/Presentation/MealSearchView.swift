//
// Meal-App
// Created by Chetan Aggarwal.


import SwiftUI

struct MealSearchView: View {
    
    @StateObject private var viewModel: MealSearchViewModel
    
    init(viewModel: MealSearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.mealList, id:\.self) { mealItem in
                Text("Meal Id: \(mealItem.id)")
            }
        }
        .task {
            viewModel.searchMeal()
        }
    }
}

//TODO: - move the factory method in the DI section for the view model
#Preview {
    MealSearchView(viewModel: MealSearchViewModel(searchItemListLoader: RemoteSearchMealListLoader(url: URL(string: "https://pokeapi.co/api/v2/pokemon?limit=10&offset=0")!, client: URLSessionHTTPClient(session: URLSession.shared))))
}
