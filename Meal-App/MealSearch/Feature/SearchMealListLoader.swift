//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

enum SearchMealListResult {
    case success([MealItem])
    case failure(Error)
}

// MARK: - SearchMealListLoader Protocol
protocol SearchMealListLoader {
    func search(searchString: String, completion: @escaping (SearchMealListResult) -> Void)
}
