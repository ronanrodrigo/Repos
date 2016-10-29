public protocol WebService {
    func load<T>(resource: Resource<T>, completion: @escaping (T?, Error?) -> ())
    func download(url: URL, completion: @escaping (Data?) -> ())
}

final class WebServiceSession: WebService {

    func load<T>(resource: Resource<T>, completion: @escaping (T?, Error?) -> ()) {
        URLSession.shared.dataTask(with: resource.url as URL) { data, _, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(resource.parse(data), error)
        }.resume()
    }

    func download(url: URL, completion: @escaping (Data?) -> ()) {
        URLSession.shared.downloadTask(with: url) {location, _, _ in
            guard let location = location else {
                completion(nil)
                return
            }
            completion(try? Data(contentsOf: location))
        }.resume()
    }

}
