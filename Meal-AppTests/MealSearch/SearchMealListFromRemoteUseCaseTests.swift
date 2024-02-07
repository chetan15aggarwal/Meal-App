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
        
        let expectedURL = url.appending(queryItems: [URLQueryItem(name: "s", value: searchString)])
        XCTAssertEqual(client.requestedURLs, [expectedURL])
    }
    
    func test_searchTwice_requestsDataFromURLTwice () {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client, searchString) = makeSUT(url: url)
        
        sut.search(searchString: searchString) { _ in }
        sut.search(searchString: searchString) { _ in }
        
        let expectedURL = url.appending(queryItems: [URLQueryItem(name: "s", value: searchString)])
        XCTAssertEqual(client.requestedURLs, [expectedURL, expectedURL])
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
        
        let item1 = MockMealItems().getItem1()
        let item2 = MockMealItems().getItem1()
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
        
        var capturedResults = [SearchMealListResult]()
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
                        toCompleteWith expectedResult: SearchMealListResult,
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
    
    
    private func failure(_ error: RemoteSearchMealListLoader.Error) -> SearchMealListResult {
        return .failure(error)
    }
    
    private func makeItemJson(_ items: [[String: Any]]) -> Data {
        let itemJson = ["meals": items] as [String : Any]
        return try! JSONSerialization.data(withJSONObject: itemJson, options: .prettyPrinted)
    }
    
}
