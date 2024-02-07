
# Meal App

This is a demo iOS App to demonstrate the search functionality on a swiftUI listing by using [The Meal DB](https://www.themealdb.com/api.php) API

![Homepage](https://github.com/chetan15aggarwal/Meal-App/assets/20903001/94fb5783-d315-4979-b89a-0d30ea699188)
![Search](https://github.com/chetan15aggarwal/Meal-App/assets/20903001/3fe64a76-dc63-4e8c-9fa9-e86cb2193b2e)
![DetailPage](https://github.com/chetan15aggarwal/Meal-App/assets/20903001/91812a98-8faf-4555-83b7-1e1f82069bc5)

## Technical Stack

### Enviroment
- Xcode 15.2
- Swift 5.9.2

### Minimum Deployment
- iOS 17.2

### Dependencies
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)

### Dependency Manager
- Swift Package Manager

### Apple frameworks
- Combine

### Architecture:
Clean Architecture with MVVM on Presentation layer. 

## Functionality

- Load the Meal List information from server launch of application
- Show all the Meal List on the screen in listing format
- provided basic information about each meal in each row
- On tap on any meal, user is redirected to new screen with details
- Show error in alert for server error

Tech Specs:
- Presentation layer implemented with MVVM architectural design pattern
- Focus on SOLID principles
- `SearchMealListLoader` is an abstract boundary. Currently it is implemented for remote fetch implementation, similarly using this abstraction layer we can fetch from cache , filesystem or core data with respective implementation.
- `SearchMealListLoader` is considered as a use case
- `HTTPClient` is an abstract boundry to interact with server. Currently it is implemented with URLSession similarly it can be implemented though other frameworks such as Alomafire
- Unit test cases added for `HTTPClient` , `SearchMealListLoader` etc
- Code Coverage enabled




