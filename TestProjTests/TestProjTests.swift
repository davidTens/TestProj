import XCTest
@testable import TestProj

final class TestProjTests: XCTestCase {

    override class func setUp() {
        super.setUp()
    }

    override class func tearDown() {
        super.tearDown()
    }

    func testExample() throws {

        let testNumber = 9
        let sum = 81
        XCTAssertEqual(testNumber * testNumber, sum)
    }
}
