struct Resource<A> {
    let url: NSURL
    let parse: (Data) -> A?
}

extension Resource {

    init(url: NSURL, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data as Data, options: [])
            return json.flatMap(parseJSON)
        }
    }

}
