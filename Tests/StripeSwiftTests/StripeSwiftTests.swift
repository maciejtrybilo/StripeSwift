import XCTest
@testable import StripeSwift

class StripeSwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(StripeSwift().text, "Hello, World!")
    }


    static var allTests : [(String, (StripeSwiftTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
