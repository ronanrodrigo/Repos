import Shared

class WebServiceFake<U>: WebService {

    var returnedEntity: U?

    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        completion(returnedEntity as? T)
    }

}
