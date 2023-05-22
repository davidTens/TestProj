import XCTest
@testable import TestProj

final class MockItemsViewService: XCTestCase, ItemsServiceProviding {
    
    func getData(itemsPerPage: Int, completion: @escaping TestProj.APIResult) {
        let itemModel = ArtObjects(id: "23", title: "title", longTitle: "longTitle", principalOrFirstMaker: "maker", productionPlaces: ["Amsterdam", "Vienna"], headerImage: .init(url: ""))
        completion(.success([itemModel]))
    }
}

final class TestProjTests: XCTestCase {

    private var viewModel: ItemsViewModel!
    private var viewService: MockItemsViewService!

    override func setUp() {
        super.setUp()

        viewService = MockItemsViewService()
        viewModel = ItemsViewModel(viewService: viewService)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() throws {

        let testNumber = 9
        let sum = 81
        XCTAssertEqual(testNumber * testNumber, sum)
    }
}
