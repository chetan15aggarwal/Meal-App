//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

struct SearchMealModule {
    func provideSearchMealListLoader() -> SearchMealListLoader {
        return RemoteSearchMealListLoader(url: MealAPI.Endpoint.getSearchAPI.url!, client: URLSessionHTTPClient(session: URLSession.shared))
    }
    
    @MainActor
    func provideSearchMealViewModel() -> MealSearchViewModel {
        let loader = provideSearchMealListLoader()
        return MealSearchViewModel(searchItemListLoader: loader)
    }
}
