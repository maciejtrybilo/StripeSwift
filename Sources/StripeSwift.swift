import HTTP
import Transport
import Vapor

typealias StripeClient = Client<TCPClientStream, Serializer<Request>, Parser<Response>>

public struct StripeSwift {
    
    private let authorizationHeader: String
    
    public init?(apiKey: String) {
        
        guard let utf8Data = apiKey.data(using: .utf8) else {
            return nil
        }
        
        self.authorizationHeader = "Basic \(utf8Data.base64EncodedString())"
    }
    
    public func charges() -> JSON? {
        
        let response = try? StripeClient.get("https://api.stripe.com/v1/charges",
                                             headers: ["Authorization" : authorizationHeader]
        )
        
        return response?.json
    }
    
    public func charge(charge: Charge) -> JSON? {
        
        let response = try? StripeClient.post("https://api.stripe.com/v1/charges",
                                              headers: ["Authorization" : authorizationHeader,
                                                        "Content-Type"  : "application/json"],
                                              body: Body.data(charge.makeNode().formURLEncoded())
        )
        
        return response?.json
    }
}
