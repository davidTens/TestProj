import Foundation

struct NetworkClient {
    private let urlRepository: URLRepository
    private let apiKey: String
    private let decoder: JSONDecoder
    private let session: URLSession

    init(
        urlRepository: URLRepository,
        apiKey: String = "0fiuZFh4",
        decoder: JSONDecoder = .init(),
        session: URLSession = .shared
    ) {
        self.urlRepository = urlRepository
        self.apiKey = apiKey
        self.decoder = decoder
        self.session = session
    }

    func getData<T>(
        itemsPerPage: Int,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) where T: Decodable {

        let queryParameters = "?key=\(apiKey)&ps=\(String(itemsPerPage))"
        let urlString = urlRepository.baseURL + queryParameters
        guard let url = URL(string: urlString)
        else {
            return completion(.failure(.invalidURL))
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200
            else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data
            else {
                completion(.failure(.serializationFailed))
                return
            }
            
            do {
                let items = try decoder.decode(T.self, from: data)
                completion(.success(items))
            }
            catch {
                completion(.failure(.serializationFailed))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case serializationFailed
}
