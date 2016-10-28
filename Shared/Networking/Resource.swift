public typealias JSONDictionary = [String: AnyObject]

public struct Resource<A> {
    public let url: URL
    public let parse: (Data) -> A?
}

public extension Resource {

    public init(url: URL, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data as Data, options: [])
            return json.flatMap(parseJSON)
        }
    }

}
