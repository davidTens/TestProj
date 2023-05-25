import UIKit

final class ItemsViewCell: UITableViewCell {

    private let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()

    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }

    private func setupSubViews() {
        addSubview(itemImageView)
        addSubview(title)

        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -8
            ),
            title.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            title.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),

            itemImageView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            itemImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            itemImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            itemImageView.bottomAnchor.constraint(
                equalTo: title.topAnchor,
                constant: -8
            )
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemsViewCell {
    func configure(with model: ArtObject) {
        title.text = model.longTitle
        itemImageView.loadImageUsingCacheWithURL(urlString: model.headerImage.url)
    }
}
