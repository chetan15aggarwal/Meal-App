//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

typealias Ingredients = [String: String] // [Ingredients: Measurements]
struct MealItem {
    var id: Double
    var category: String
    var area: String
    var instructions: String
    var mealThumbUrl: URL
    var tags: [String]
    var youtubeUrl: URL
    var sourceUrl: URL
    var ingredients: Ingredients
}
