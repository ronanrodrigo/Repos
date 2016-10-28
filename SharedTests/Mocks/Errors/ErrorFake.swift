enum ErrorFake: Error {
    case error
    var localizedDescription: String {
        get {
            return "Fake error"
        }
    }
}
