import XCTest
@testable import TestProj

final class MockItemsViewService: XCTestCase, ItemsServiceProviding {

    var shouldSuccess = true
    
    func getData(itemsPerPage: Int, completion: @escaping TestProj.APIResult) {
        let itemModel = ArtObject(id: UUID().uuidString, title: "title", longTitle: "longTitle", principalOrFirstMaker: "maker", productionPlaces: ["Amsterdam", "Vienna"], headerImage: .init(url: ""))

        if shouldSuccess {
            completion(.success([itemModel]))
        } else {
            completion(.failure(.invalidURL))
        }
    }
}
