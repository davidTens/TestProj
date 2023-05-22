import Foundation
import Combine

final class ItemsViewModel {

    // MARK: - Dependencies

    private let viewService: ItemsViewService

    // MARK: - properties

    private(set) var itemsPerPage: Int = 0
    private let pageLimit = 10000
    @Published var fetchingState: FetchingState = .loading
    private var cancellables = Set<AnyCancellable>()
    private let artObjectsSubject = CurrentValueSubject<[ArtObjects], Never>([])
    private(set) lazy var artObjectModel: AnyPublisher<[ArtObjects], Never> = makeArtObjectModel()

    // MARK: - Init

    init(viewService: ItemsViewService) {
        self.viewService = viewService
    }

    func fetch() {
        itemsPerPage += 10
        guard itemsPerPage < pageLimit else { return }

        fetchingState = .loading
        viewService.getData(itemsPerPage: itemsPerPage, completion: handleAPIResults)
    }

    private func handleAPIResults(_ result: Result<[ArtObjects], NetworkError>) {
        switch result {
        case .success(let items):
            artObjectsSubject.send(items)
            fetchingState = .done
        case .failure(let error):
            fetchingState = .error(error)
        }
    }

    private func makeArtObjectModel() -> AnyPublisher<[ArtObjects], Never> {
        artObjectsSubject
            .eraseToAnyPublisher()
    }
}

enum FetchingState {
    case loading
    case done
    case error(Error)
}
