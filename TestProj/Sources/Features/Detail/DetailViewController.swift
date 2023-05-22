import UIKit

final class DetailViewController: UIViewController {

    private let headerImageView: UIImageView = {
        let headerImageView = UIImageView()
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.backgroundColor = .lightGray
        return headerImageView
    }()

    private let imageTitle: UILabel = {
        let imagetitle = UILabel()
        imagetitle.translatesAutoresizingMaskIntoConstraints = false
        imagetitle.numberOfLines = 0
        return imagetitle
    }()

    private let principalOrFirstMaker: UILabel = {
        let principalOrFirstMaker = UILabel()
        principalOrFirstMaker.translatesAutoresizingMaskIntoConstraints = false
        principalOrFirstMaker.numberOfLines = 0
        return principalOrFirstMaker
    }()

    private let viewData: DetailViewData

    init(viewData: DetailViewData) {
        self.viewData = viewData
        headerImageView.loadImageUsingCacheWithURL(urlString: viewData.headerImage)
        imageTitle.text = "Title - \n\(viewData.imageTitleText)"
        principalOrFirstMaker.text = "Principal or first maker - \n\(viewData.principalOrFirstMakerText)"
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = viewData.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews()
    }

    private func setupSubViews() {
        view.addSubview(headerImageView)

        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        let stackView = UIStackView(arrangedSubviews: [imageTitle, principalOrFirstMaker])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
    }
}

