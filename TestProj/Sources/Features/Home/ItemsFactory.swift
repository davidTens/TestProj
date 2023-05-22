import Foundation

struct ItemsFactory {
    static func makeViewModel() -> ItemsViewModel {
        let urlRepo = URLRepository()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let client = NetworkClient(urlRepository: urlRepo, decoder: decoder)
        let viewService = ItemsViewService(networkClient: client)
        let viewModel = ItemsViewModel(viewService: viewService)
        return viewModel
    }
}
