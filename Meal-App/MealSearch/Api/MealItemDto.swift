//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

struct MealItemDto: Decodable {
    var idMeal: Double
    var strMeal: String
    var strCategory: String
    var strArea: String
    var strInstructions: String
    var strMealThumb: String
    var strTags: String
    var strYoutube: String
    var strSource: String

    var strIngredient1: String
    var strIngredient2: String
    var strIngredient3: String
    var strIngredient4: String
    var strIngredient5: String
    var strIngredient6: String
    var strIngredient7: String
    var strIngredient8: String
    var strIngredient9: String
    var strIngredient10: String
    var strIngredient11: String
    var strIngredient12: String
    var strIngredient13: String
    var strIngredient14: String
    var strIngredient15: String
    var strIngredient16: String
    var strIngredient17: String
    var strIngredient18: String
    var strIngredient19: String
    var strIngredient20: String
    
    var strMeasure1: String
    var strMeasure2: String
    var strMeasure3: String
    var strMeasure4: String
    var strMeasure5: String
    var strMeasure6: String
    var strMeasure7: String
    var strMeasure8: String
    var strMeasure9: String
    var strMeasure10: String
    var strMeasure11: String
    var strMeasure12: String
    var strMeasure13: String
    var strMeasure14: String
    var strMeasure15: String
    var strMeasure16: String
    var strMeasure17: String
    var strMeasure18: String
    var strMeasure19: String
    var strMeasure20: String
    
    //ignored keys because of null response
    //strDrinkAlternate, strImageSource, strCreativeCommonsConfirmed, dateModified
}

struct Root: Decodable {
    let meals: [MealItemDto]
}

extension Array where Element == MealItemDto {
    func toModels() -> [MealItem] {
        return map {
            MealItem(id: $0.idMeal,
                     name: $0.strMeal,
                     category: $0.strCategory,
                     area: $0.strArea,
                     instructions: $0.strInstructions,
                     mealThumbUrl: URL(string: $0.strMealThumb) ?? nil,
                     tags: $0.strTags.components(separatedBy: ","),
                     youtubeUrl: URL(string: $0.strYoutube) ?? nil,
                     sourceUrl: URL(string: $0.strSource) ?? nil,
                     ingredients: [
                        Ingredient(ingredientName: $0.strIngredient1, measurement: $0.strMeasure1),
                        Ingredient(ingredientName: $0.strIngredient2, measurement: $0.strMeasure2),
                        Ingredient(ingredientName: $0.strIngredient3, measurement: $0.strMeasure3),
                        Ingredient(ingredientName: $0.strIngredient4, measurement: $0.strMeasure4),
                        Ingredient(ingredientName: $0.strIngredient5, measurement: $0.strMeasure5),
                        Ingredient(ingredientName: $0.strIngredient6, measurement: $0.strMeasure6),
                        Ingredient(ingredientName: $0.strIngredient7, measurement: $0.strMeasure7),
                        Ingredient(ingredientName: $0.strIngredient8, measurement: $0.strMeasure8),
                        Ingredient(ingredientName: $0.strIngredient9, measurement: $0.strMeasure9),
                        Ingredient(ingredientName: $0.strIngredient10, measurement: $0.strMeasure10),
                        Ingredient(ingredientName: $0.strIngredient11, measurement: $0.strMeasure11),
                        Ingredient(ingredientName: $0.strIngredient12, measurement: $0.strMeasure12),
                        Ingredient(ingredientName: $0.strIngredient13, measurement: $0.strMeasure13),
                        Ingredient(ingredientName: $0.strIngredient14, measurement: $0.strMeasure14),
                        Ingredient(ingredientName: $0.strIngredient15, measurement: $0.strMeasure15),
                        Ingredient(ingredientName: $0.strIngredient16, measurement: $0.strMeasure16),
                        Ingredient(ingredientName: $0.strIngredient17, measurement: $0.strMeasure17),
                        Ingredient(ingredientName: $0.strIngredient18, measurement: $0.strMeasure18),
                        Ingredient(ingredientName: $0.strIngredient19, measurement: $0.strMeasure19),
                        Ingredient(ingredientName: $0.strIngredient20, measurement: $0.strMeasure20)
                     ]
            )
        }
    }
}
