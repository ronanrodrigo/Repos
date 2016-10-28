public protocol WebService {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ())
}

final class WebServiceSession: WebService {

    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: resource.url as URL) { data, _, error in
            guard let data = data else { return }
            completion(resource.parse(data as Data))
        }.resume()
    }

}
