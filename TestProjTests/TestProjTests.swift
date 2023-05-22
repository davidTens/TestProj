import XCTest
@testable import TestProj

final class TestProjTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let testNumber = 9
        let sum = 81
        XCTAssertEqual(testNumber * testNumber, sum)
    }
}
