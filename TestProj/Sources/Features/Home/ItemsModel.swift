import Foundation

struct ItemsModel: Decodable {
    let artObjects: [ArtObject]

    init(artObjects: [ArtObject]) {
        self.artObjects = artObjects
    }
}

struct ArtObject: Decodable, Hashable, Identifiable {
    let id: String
    let title: String
    let longTitle: String
    let principalOrFirstMaker: String
    let productionPlaces: [String]
    let headerImage: HeaderImage

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ArtObject, rhs: ArtObject) -> Bool {
        return lhs.id == rhs.id
    }
}

struct HeaderImage: Decodable {
    let url: String
}
