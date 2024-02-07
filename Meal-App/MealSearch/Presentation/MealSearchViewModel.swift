//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation
import Combine

@MainActor
final class MealSearchViewModel:ObservableObject {
    @Published var mealList: [MealItem] = [MealItem]()
    @Published var searchText: String = ""
    
    private let searchItemListLoader: SearchMealListLoader
    var searchError: Error? = nil
    
    private var cancellable: Set<AnyCancellable> = []

    init(searchItemListLoader: SearchMealListLoader) {
        self.searchItemListLoader = searchItemListLoader
        
        $searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.searchMeal(for: text)
            }
            .store(in: &cancellable)
    }
    
    func searchMeal(for query: String) {
        searchItemListLoader.search(searchString: searchText) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(items):
                DispatchQueue.main.async {
                    self.mealList = items
                }
            case let .failure(error):
                searchError = error.localizedDescription as? any Error
            }
        }
    }
}
