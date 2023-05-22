import XCTest
@testable import TestProj

final class TestProjTests: XCTestCase {
    func testExample() throws {

        let testNumber = 9
        let sum = 81
        XCTAssertEqual(testNumber * testNumber, sum)
    }
}
