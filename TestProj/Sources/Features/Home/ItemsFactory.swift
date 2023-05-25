import Foundation

struct ItemsFactory {
    static func makeViewModel() -> ItemsViewModel {
        let client = makeNetworkClient()
        let viewService = ItemsViewService(networkClient: client)
        let viewModel = ItemsViewModel(viewService: viewService)
        return viewModel
    }

    private static func makeNetworkClient() -> NetworkClient {
        let urlRepo = URLRepository()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let client = NetworkClient(urlRepository: urlRepo, decoder: decoder)
        return client
    }
}
