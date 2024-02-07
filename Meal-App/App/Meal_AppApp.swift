//
// Meal-App
// Created by Chetan Aggarwal.


import SwiftUI

@main
struct Meal_AppApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = MealSearchViewModel(searchItemListLoader: RemoteSearchMealListLoader(url: URL(string: "https://themealdb.com/api/json/v1/1/search.php")!, client: URLSessionHTTPClient(session: URLSession.shared)))
            MealSearchView(viewModel: viewModel)
        }
    }
}
