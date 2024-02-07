//
// Meal-App
// Created by Chetan Aggarwal.


import SwiftUI
import SDWebImageSwiftUI

struct MealDetailView: View {
    var meal: MealItem
    
    var body: some View {
        ScrollView {
            WebImage(url: meal.mealThumbUrl)
                .placeholder(Image(Constants.meal_img_placeholder))
                .resizable()
                .scaledToFill()
                .frame(height: 350)
                .clipped()
                .ignoresSafeArea(edges: .top)
            
            VStack(alignment: .leading) {
                
                HStack {
                    Text(meal.name)
                        .font(.title)
                    Spacer()
                }
                .padding(.bottom, 1)

                
                HStack {
                    Text(meal.category)
                    Spacer()
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 1)

                HStack {
                    ForEach(meal.tags, id: \.self) { tag in
                        Text(tag)
                            .encapsulate(color: .black.opacity(0.8), foregroundColor : .white)
                    }
                    Spacer()
                }
                .padding(.bottom)
                
                Divider()
                
                Text("Instructions for \(meal.name)")
                    .font(.title2)
                Text(meal.instructions)
            }
            .padding()
        }
        .navigationTitle(meal.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MealDetailView(meal: MealItem.preview().first!)
}
