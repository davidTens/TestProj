import XCTest
@testable import TestProj

final class MockItemsViewService: XCTestCase, ItemsServiceProviding {

    var shouldSuccess = true
    
    func getData(itemsPerPage: Int, completion: @escaping TestProj.APIResult) {
        let itemModel = ArtObjects(id: "23", title: "title", longTitle: "longTitle", principalOrFirstMaker: "maker", productionPlaces: ["Amsterdam", "Vienna"], headerImage: .init(url: ""))

        if shouldSuccess {
            completion(.success([itemModel]))
        } else {
            completion(.failure(.invalidURL))
        }
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
        viewService = nil
        viewModel = nil
        super.tearDown()
    }

    func testShuoldSuccess() {
        viewService.shouldSuccess = true

        let exptectation = XCTestExpectation(description: "API request should succeed")

        viewService.getData(itemsPerPage: 10) { result in
            switch result {
            case .success(let items):
                XCTAssertNotNil(items)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exptectation.fulfill()
        }

        wait(for: [exptectation], timeout: 4)
        XCTAssertNotNil(viewModel.artObjectModel)
    }

    func testShuoldFail() {
        viewService.shouldSuccess = false

        let expectation = XCTestExpectation(description: "API request should fail")

        viewService.getData(itemsPerPage: 10) { result in
            switch result {
            case .success(_):
                XCTFail("Success, however should fail")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
    }

    func testExample() throws {

        let testNumber = 9
        let sum = 81
        XCTAssertEqual(testNumber * testNumber, sum)
    }
}
