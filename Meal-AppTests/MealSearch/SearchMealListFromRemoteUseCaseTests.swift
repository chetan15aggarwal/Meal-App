//
// Meal-AppTests
// Created by Chetan Aggarwal.


import XCTest
@testable import Meal_App

final class SearchMealListFromRemoteUseCaseTests: XCTestCase {
    
    func test_init_deosNotRequestDataFromURL() {
        let (_, client, _ ) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_search_requestsDataFromURL() {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client, searchString) = makeSUT(url: url)
        
        sut.search(searchString: searchString, completion: { _ in })
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_searchTwice_requestsDataFromURLTwice () {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client, searchString) = makeSUT(url: url)
        
        sut.search(searchString: searchString) { _ in }
        sut.search(searchString: searchString) { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_search_deliversErrorOnClientError() {
        let (sut, client, searchString) = makeSUT()
        
        expect(searchString, sut: sut, toCompleteWith: failure(.connectivity) ) {
            let completionError = NSError(domain: "Test", code: 0)
            client.complete(with: completionError)
        }
    }
    
    func test_search_deliversErrorOnNon200HTTPResponse() {
        let (sut, client, searchString) = makeSUT()

        let samples = [199, 201, 300, 400, 500]
        samples.enumerated().forEach { index, code in
            
            expect(searchString, sut: sut, toCompleteWith: failure(.invalidData)) {
                let json = makeItemJson([])
                client.complete(withStatusCode: code, data: json, index: index)
            }
        }
    }
    
    func test_search_deliversErrorOn200HTTPResponseWithInvalidJson() {
        let (sut, client, searchString) = makeSUT()

        expect(searchString, sut: sut, toCompleteWith: failure(.invalidData)) {
            let invalidJson = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJson)
        }
    }
    
    func test_search_deliverNoItemOn200HTTPResponseWithEmptyList() {

        let (sut, client, searchString) = makeSUT()

        expect(searchString, sut: sut, toCompleteWith: .success([])) {
            let invalidJson = makeItemJson([])
            client.complete(withStatusCode: 200, data: invalidJson)
        }
    }
    
    func test_seach_diliverItemsOn200HTTPResponseWithJsonItems() {
        let (sut, client, searchString) = makeSUT()
        
        let item1 = makeItem(id: 1111, name: "Kumpir", category: "Side", area: "Turkish", instructions: "If you order kumpir in Turkey", mealThumbUrl: URL(string: "https://www.themealdb.com/images/media/meals/mlchx21564916997.jpg")!, tags: ["SideDish"], youtubeUrl: URL(string: "https://www.youtube.com/watch?v=IEDEtZ4UVtI")!, sourceUrl: URL(string: "http://www.turkeysforlife.com/2013/10/firinda-kumpir-turkish-street-food.html")!, ingredients: [Ingredient(ingredientName: "Potatoes", measurement: "2 large"), Ingredient(ingredientName: "Butter", measurement: "2 tbs")])
        
        let item2 = makeItem(id: 222, name: "Poutine", category: "Miscellaneous", area: "Canadian", instructions: "If you order kumpir in Turkey", mealThumbUrl: URL(string: "https://www.themealdb.com/images/media/meals/mlchx21564916997.jpg")!, tags: ["SideDish"], youtubeUrl: URL(string: "https://www.youtube.com/watch?v=IEDEtZ4UVtI")!, sourceUrl: URL(string: "http://www.turkeysforlife.com/2013/10/firinda-kumpir-turkish-street-food.html")!, ingredients: [Ingredient(ingredientName: "Vegetable Oil", measurement: "2 large"), Ingredient(ingredientName: "Butter", measurement: "2 tbs")])
        
        let items = ([item1.model, item2.model])

        
        expect(searchString, sut: sut, toCompleteWith: .success(items)) {
            let jsonData = makeItemJson([item1.json, item2.json])

            client.complete(withStatusCode: 200, data: jsonData)
        }
    }
    
    func test_search_doesNotDeliverResultAfterSUTHasBeenDeallocated() {
        let url = URL(string: "http://a-url.com")!
        let client = HTTPClientSpy()
        let searchString = "string"

        var sut: RemoteSearchMealListLoader? = RemoteSearchMealListLoader(url: url, client: client)
        
        var capturedResults = [RemoteSearchMealListLoader.Result]()
        sut?.search(searchString: searchString ){ capturedResults.append($0) }
        sut = nil
        
        client.complete(withStatusCode: 200, data: makeItemJson([]))
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "http://a-given-url.com")!,
                         file: StaticString = #filePath,
                         line: UInt = #line) -> (RemoteSearchMealListLoader, HTTPClientSpy, String) {
        
        let client = HTTPClientSpy()
        let sut = RemoteSearchMealListLoader(url: url, client: client)
        let searchString = "string"

        trackMemoryLeak(sut, file: file, line: line)
        trackMemoryLeak(client, file: file, line: line)
        
        return (sut, client, searchString)
    }
    
    private func expect(_ searchString: String, sut: RemoteSearchMealListLoader,
                        toCompleteWith expectedResult: RemoteSearchMealListLoader.Result,
                        file: StaticString = #filePath,
                        line: UInt = #line,
                        when action: () -> Void ) {
        
        let exp = expectation(description: "Wait for load comletion")
        
        sut.search(searchString: searchString) { receivedResults in
            switch (receivedResults, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
            case let (.failure(receivedError as RemoteSearchMealListLoader.Error), .failure(expectedError as RemoteSearchMealListLoader.Error)):
                XCTAssertEqual(receivedError, expectedError)
            default:
                XCTFail("expected result \(expectedResult) got \(receivedResults) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        
        action()
        wait(for: [exp], timeout: 1.0)
    }
    
    
    private func failure(_ error: RemoteSearchMealListLoader.Error) -> RemoteSearchMealListLoader.Result {
        return .failure(error)
    }
    
    private func makeItemJson(_ items: [[String: Any]]) -> Data {
        let itemJson = ["meals": items] as [String : Any]
        return try! JSONSerialization.data(withJSONObject: itemJson, options: .prettyPrinted)
    }
    
    private func makeItem(id: Double, name: String, category: String, area: String, instructions: String, mealThumbUrl: URL, tags: [String], youtubeUrl: URL, sourceUrl: URL, ingredients: [Ingredient]) -> (model: MealItem, json: [String: Any]) {
        
        var allIngredients: [Ingredient] = []
        for i in 0..<20 {
            let local = Ingredient(
                ingredientName: i < ingredients.count ? ingredients[i].ingredientName:"",
                measurement: i < ingredients.count ? ingredients[i].measurement:""
            )
            allIngredients.append(local)
        }
        
        let item = MealItem(id: id, name: name, category: category, area: area, instructions: instructions, mealThumbUrl: mealThumbUrl, tags: tags, youtubeUrl: youtubeUrl, sourceUrl: sourceUrl, ingredients: allIngredients)
        
        var json: [String: Any] = [
            "idMeal": id,
            "strMeal" : name,
            "strCategory": category,
            "strArea": area,
            "strInstructions": instructions,
            "strMealThumb": mealThumbUrl.absoluteString,
            "strTags": tags.joined(separator: ","),
            "strYoutube": youtubeUrl.absoluteString,
            "strSource": sourceUrl.absoluteString,
        ]
        
        for i in 0..<20 {
            json["strIngredient\(i+1)"] = i < ingredients.count ? ingredients[i].ingredientName : ""
            json["strMeasure\(i+1)"] = i < ingredients.count ? ingredients[i].measurement: ""
        }
        
        return (item, json)
    }
    
    // MARK: - HTTPClientSpy
    private final class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void ) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data, index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil)!
            messages[index].completion(.success(data, response))
        }
    }
}
