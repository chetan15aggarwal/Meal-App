//
// Meal-AppTests
// Created by Chetan Aggarwal.


import XCTest
@testable import Meal_App

final class SearchMealListFromRemoteUseCaseTests: XCTestCase {
    
    func test_init_deosNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "http://a-given-url.com")!,
                         file: StaticString = #filePath,
                         line: UInt = #line) -> (SearchMealListLoader, HTTPClientSpy) {
        
        let client = HTTPClientSpy()
        let sut = RemoteSearchMealListLoader(url: url, client: client)
    
        trackMemoryLeak(sut, file: file, line: line)
        trackMemoryLeak(client, file: file, line: line)
        
        return (sut, client)
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