import ArgumentParser
import WebSocketActors


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
        print("starting server...")
        let address = ServerAddress(scheme: .insecure, host: "localhost", port: 8888)
        let system = WebSocketActorSystem()
        try await system.runServer(at: address)

        _ = system.makeLocalActor(id: .greeter) {
           Greeter(actorSystem: system)
        }

        print("running.")

        while true {
           try await Task.sleep(for: .seconds(1))
        }
    }
}


extension DAWS {
    func runClient() async throws {
        print("starting client...")
        let address = ServerAddress(scheme: .insecure, host: "localhost", port: 8888)
        let system = WebSocketActorSystem()

        print("connecting...")
        try await system.connectClient(to: address)

        print("resolving Greeter...")
        let greeter = try Greeter.resolve(id: .greeter, using: system)

        print("calling greet...")
        let greeting = try await greeter.greet(name: "Alice")

        print("greeting received:", greeting)
        print("done.")
    }
}


enum Mode: String, ExpressibleByArgument {
    case client
    case server
}
