import Foundation

struct ItemsModel: Decodable {
    let artObjects: [ArtObjects]

    init(artObjects: [ArtObjects]) {
        self.artObjects = artObjects
    }
}

struct ArtObjects: Decodable, Hashable, Identifiable {
    let id: String
    let title: String
    let longTitle: String
    let principalOrFirstMaker: String
    let productionPlaces: [String]
    let headerImage: HeaderImage

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ArtObjects, rhs: ArtObjects) -> Bool {
        return lhs.id == rhs.id
    }
}

struct HeaderImage: Decodable {
    let url: String
}
