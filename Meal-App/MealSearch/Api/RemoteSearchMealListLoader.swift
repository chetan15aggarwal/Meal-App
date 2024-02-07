//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

final class RemoteSearchMealListLoader: SearchMealListLoader {
    typealias Result = SearchMealListResult
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    // MARK: - Properties and Initializer
    private let url: URL
    private let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    // MARK: - SearchMealListLoader
    func search(searchString: String, completion: @escaping (SearchMealListResult) -> Void) {
        let updatedUrl = url.appending(queryItems: [URLQueryItem(name: "s", value: searchString)])
        client.get(from: updatedUrl) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                completion(RemoteSearchMealListLoader.map(data, response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, _ response: HTTPURLResponse) -> Result {
        do {
            let items = try MealListItemMapper.map(data, response)
            return .success(items.toModels())
        } catch {
            return .failure(error)
        }
    }
}
