import Foundation
import Combine

final class ItemsViewModel {

    // MARK: - Dependencies

    private let viewService: any ItemsServiceProviding

    // MARK: - properties

    private(set) var itemsPerPage: Int = 0
    private let pageLimit = 10000
    @Published var fetchingState: FetchingState = .loading
    private var cancellables = Set<AnyCancellable>()
    private let artObjectsSubject = CurrentValueSubject<[ArtObject], Never>([])
    private(set) lazy var artObjectModel: AnyPublisher<[ArtObject], Never> = makeArtObjectModel()

    // MARK: - Init

    init(viewService: any ItemsServiceProviding) {
        self.viewService = viewService
    }

    func fetch() {
        itemsPerPage += 10
        guard itemsPerPage < pageLimit else { return }

        fetchingState = .loading
        viewService.getData(
            itemsPerPage: itemsPerPage,
            completion: handleAPIResults
        )
    }

    private func handleAPIResults(
        _ result: Result<[ArtObject], NetworkError>
    ) {
        switch result {
        case .success(let items):
            artObjectsSubject.send(items)
            fetchingState = .done
        case .failure(let error):
            fetchingState = .error(error)
        }
    }

    private func makeArtObjectModel() -> AnyPublisher<[ArtObject], Never> {
        artObjectsSubject
            .eraseToAnyPublisher()
    }
}

enum FetchingState {
    case loading
    case done
    case error(Error)
}
