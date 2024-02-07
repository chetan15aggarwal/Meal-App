//
// Meal-App
// Created by Chetan Aggarwal.


import SwiftUI
import SDWebImageSwiftUI

struct MealCardView: View {
    var meal: MealItem
    
    var body: some View {
        GroupBox {
            WebImage(url: meal.mealThumbUrl)
                .placeholder(Image(Constans.meal_img_placeholder))
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
            
            VStack {
                HStack {
                    Text(meal.name)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(meal.area)
                        .font(.subheadline)
                }
                .padding(.bottom, 1)
                
                HStack(spacing: 0) {
                    Text(meal.category)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.bottom, 1)
                
                HStack {
                    ForEach(meal.tags, id: \.self) { tag in
                        Text(tag)
                            .encapsulate(color: .black.opacity(0.8), foregroundColor : .white)
                    }
                    Spacer()
                }
                .padding(.bottom)
            }
            .padding(.horizontal, 15)
        }
        .groupBoxStyle(CardGroupBoxStyle())
    }
}

struct MealCardView_Previews: PreviewProvider {
    static var previews: some View {
        MealCardView(meal: MealItem.preview().first!)
            .padding()
    }
}
