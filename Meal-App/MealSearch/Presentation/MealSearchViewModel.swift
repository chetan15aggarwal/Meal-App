//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

@MainActor
final class MealSearchViewModel:ObservableObject {
    private let searchItemListLoader: SearchMealListLoader
    @Published var mealList: [MealItem] = [MealItem]()
    @Published var searchString: String = ""
    var searchError: Error? = nil
    
    init(searchItemListLoader: SearchMealListLoader) {
        self.searchItemListLoader = searchItemListLoader
    }
    
    func searchMeal() {
        searchItemListLoader.search(searchString: searchString) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(items):
                DispatchQueue.main.async {
                    self.mealList = items
                }
            case let .failure(error):
                //trigger error logic
                searchError = error.localizedDescription as? any Error
            }
        }
    }
}
