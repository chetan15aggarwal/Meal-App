//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

extension MealItem {
    static func preview() -> [MealItem] {
        return [MealItem(
            id: "52771",
            name: "Spicy Arrabiata Penne",
            category: "Vegetarian",
            area: "Italian",
            instructions: "Bring a large pot of water to a boil.",
            mealThumbUrl: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg".asURL, tags: ["Pasta","Curry"],
            youtubeUrl: "https://www.youtube.com/watch?v=1IszT_guI08".asURL,
            ingredients: [Ingredient("penne rigate", measurement: "1 pound")!,Ingredient("olive oil", measurement: "1/4 cup")!]
        ), MealItem(
            id: "51771",
            name: "Pizza",
            category: "Vegetarian",
            area: "Italian",
            instructions: "Bring a large pot of water to a boil.",
            mealThumbUrl: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg".asURL, tags: ["Pasta","Curry"],
            youtubeUrl: "https://www.youtube.com/watch?v=1IszT_guI08".asURL,
            ingredients: [Ingredient("penne rigate", measurement: "1 pound")!,Ingredient("olive oil", measurement: "1/4 cup")!]
        )]
    }
}
