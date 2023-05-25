import Foundation

typealias APIResult = (Result<[ArtObject], NetworkError>) -> Void

protocol ItemsServiceProviding: AnyObject {
    func getData(itemsPerPage: Int, completion: @escaping APIResult)
}

final class ItemsViewService: ItemsServiceProviding {

    // MARK: - dependencies

    private let networkClient: NetworkClient

    // MARK: - init

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getData(
        itemsPerPage: Int,
        completion: @escaping APIResult
    ) {
        networkClient.getData(
            itemsPerPage: itemsPerPage
        )
        { (result: Result<ItemsModel, NetworkError>) in

            switch result {
            case .success(let items):
                completion(.success(
                    items.artObjects.map({ object in
                        ArtObject(
                            id: object.id,
                            title: object.title,
                            longTitle: object.longTitle,
                            principalOrFirstMaker: object.principalOrFirstMaker,
                            productionPlaces: object.productionPlaces,
                            headerImage: object.headerImage
                        )
                    })
                ))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
