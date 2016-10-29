import Shared

class WebServiceFake<U>: WebService {

    var returnedEntity: U?
    var error: Error?

    func load<T>(resource: Resource<T>, completion: @escaping (T?, Error?) -> ()) {
        completion(returnedEntity as? T, error)
    }

    func download(url: URL, completion: @escaping (Data?) -> ()) {
        guard let returnedEntity = returnedEntity as? Data else { return }
        completion(returnedEntity)
    }

}
