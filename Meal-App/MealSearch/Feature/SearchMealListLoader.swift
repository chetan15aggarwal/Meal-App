//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

typealias SearchMealListResult = Result<[MealItem], Error>

// MARK: - SearchMealListLoader Protocol
protocol SearchMealListLoader {
    func search(searchString: String, completion: @escaping (SearchMealListResult) -> Void)
}
