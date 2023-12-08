import Distributed
import WebSocketActors

extension NodeIdentity {
   public static let server = NodeIdentity(id: "server")
}

extension ActorIdentity {
   public static let greeter = ActorIdentity(id: "greeter", node: .server)
}

public distributed actor Greeter {
   public typealias ActorSystem = WebSocketActorSystem

   public distributed func greet(name: String) -> String {
      return "Hello, \(name)!"
   }
}
