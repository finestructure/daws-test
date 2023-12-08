import ArgumentParser


@main
struct DAWS: AsyncParsableCommand {
    @Argument
    var mode: Mode


    mutating func run() async throws {
        switch mode {
            case .server:
                try await runServer()
            case .client:
                try await runClient()
        }
    }
}


extension DAWS {
    func runServer() async throws {
        print("server running")
    }
}


extension DAWS {
    func runClient() async throws {
        print("client running")
    }
}


enum Mode: String, ExpressibleByArgument {
    case client
    case server
}