
# Meal App

This is a demo iOS App to demonstrate the search functionality on a swiftUI listing by using [The Meal DB](https://www.themealdb.com/api.php) API

![Homepage](https://github.com/chetan15aggarwal/Meal-App/assets/20903001/913b414c-ee83-474a-8896-a683b0726abe)
![Search](https://github.com/chetan15aggarwal/Meal-App/assets/20903001/1aae0eb3-5e74-43ae-a06f-03f9d92fc370)
![DetailPage](https://github.com/chetan15aggarwal/Meal-App/assets/20903001/e68b7a64-0d9d-426f-a517-25b198a96914)

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

### Flow chart of search:

![RecipeFlowDaigram drawio](https://github.com/chetan15aggarwal/Meal-App/assets/20903001/c62dcae1-6fd8-43db-abb9-d8dc94995f5c)

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


## Search Meal Feature Specs

### Story: Customer requests to see their image feed

### Narrative #1

As an online customer
I want the app to automatically load my latest meals
So I can always enjoy the newest meals and I am able to search on it.


#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
 When the customer requests to see meals
 Then the app should display the latest meals from remote
```

## Use Cases

### Search Meals From Remote Use Case

#### Data:
- URL

#### Primary course (happy path):
1. Execute "Search Meal Item" command with above data.
2. System downloads data from the URL.
3. System validates downloaded data.
4. System creates Meal List from valid data.
5. System delivers Meal Item.

#### Invalid data – error course (sad path):
1. System delivers invalid data error.

#### No connectivity – error course (sad path):
1. System delivers connectivity error.

---

