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
        NavigationStack {
            List(viewModel.mealList) { mealItem in
                ZStack(alignment: .leading) {
                    MealCardView(meal: mealItem)
                    NavigationLink(destination: MealDetailView(meal: mealItem)) {
                        EmptyView()
                    }
                    .opacity(0.0)
                }
                .listRowSeparator(.hidden, edges: .all)
            }
            .listStyle(.plain)
            .navigationTitle("Lets Eat a MEAL👨🏻‍🍳")
            .searchable(text: $viewModel.searchText)
        }
    }
}

//TODO: - move the factory method in the DI section for the view model
#Preview {
    MealSearchView(viewModel: MealSearchViewModel(searchItemListLoader: RemoteSearchMealListLoader(url: URL(string: "https://pokeapi.co/api/v2/pokemon?limit=10&offset=0")!, client: URLSessionHTTPClient(session: URLSession.shared))))
}
