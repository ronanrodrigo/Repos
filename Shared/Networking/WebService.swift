final class Webservice {

    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
        URLSession.shared.dataTask(with: resource.url as URL) { data, response, error in
            guard let data = data else { return }
            completion(resource.parse(data as Data))
            }.resume()
    }

}
