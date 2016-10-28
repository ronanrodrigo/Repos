public protocol WebService {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ())
}

final class WebServiceSession: WebService {

    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
        URLSession.shared.dataTask(with: resource.url as URL) { data, _, error in
            guard let data = data else { return }
            completion(resource.parse(data as Data))
            }.resume()
    }

}
