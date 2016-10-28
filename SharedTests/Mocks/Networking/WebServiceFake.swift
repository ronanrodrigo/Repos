import Shared

class WebServiceFake: WebService {

    var returnedEntity: A?

    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
        completion(returnedEntity)
    }

}
