import UIKit
import Combine

final class ViewController: UIViewController {

    // MARK: - Dependencies

    private let viewModel: ItemsViewModel

    // MARK: - properties

    private var cancellables = Set<AnyCancellable>()

    private let cellId = "cellId"

    private typealias DiffableDataSource = UITableViewDiffableDataSource<ItemsSection, ArtObjects>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ItemsSection, ArtObjects>

    private var dataSource: UITableViewDiffableDataSource<ItemsSection, ArtObjects>!
    private var snapshot = Snapshot()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 200
        tableView.register(ItemsViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Init

    init(viewModel: ItemsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TestProj"
        view.backgroundColor = .white
        setupSubViews()
        setupDiffableDataSource()
        snapshot.appendSections([.main])
        bindViewModel()
        viewModel.fetch()
    }

    private func bindViewModel() {
        viewModel.artObjectModel
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                self?.udpateSnapshots(items)
            }
            .store(in: &cancellables)

        viewModel.$fetchingState
            .receive(on: RunLoop.main)
            .sink { state in
                switch state {
                case .loading:
                    self.navigationItem.title = "loading"
                case .done:
                    self.navigationItem.title = "TestProj"
                case .error(let error):
                    self.navigationItem.title = error.localizedDescription
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupSubViews() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupDiffableDataSource() {
        dataSource = DiffableDataSource(tableView: tableView) { [weak self] (tableView, indexPath, item) -> UITableViewCell in
            switch self?.dataSource.snapshot().sectionIdentifiers[indexPath.section] {
            case .main:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ItemsViewCell
                cell.configure(titleText: item.longTitle, imageURL: item.headerImage.url)
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
        }
    }

    private func udpateSnapshots(_ items: [ArtObjects]) {
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.itemIdentifier(for: indexPath)
        let detailViewController = DetailViewController(viewData: .init(title: item?.title ?? "", headerImage: item?.headerImage.url ?? "", imageTitleText: item?.longTitle ?? "", principalOrFirstMakerText: item?.principalOrFirstMaker ?? ""))
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            guard snapshot.numberOfItems == viewModel.itemsPerPage else { return }
            viewModel.fetch()
        }
    }
}
