//
// Meal-AppTests
// Created by Chetan Aggarwal.


import XCTest
@testable import Meal_App

class StringExtensionTests: XCTestCase {
    
    func test_withURLValid() {
        let validURLString = "https://www.example.com"
        
        let url = validURLString.asURL
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, validURLString)
    }
    
    func test_withEmptyURL() {
        let emptyURLString = ""
        
        let url = emptyURLString.asURL
        
        XCTAssertNil(url)
    }
}
