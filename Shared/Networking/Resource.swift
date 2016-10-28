public typealias JSONDictionary = [String: AnyObject]

public struct Resource<T> {
    public let url: URL
    public let parse: (Data) -> T?
}

public extension Resource {

    public init(url: URL, parseJSON: @escaping (Any) -> T?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data as Data, options: [])
            return json.flatMap(parseJSON)
        }
    }

}
