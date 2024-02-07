//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation
typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

// MARK: - HTTPClient Protocol
protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void )
}
