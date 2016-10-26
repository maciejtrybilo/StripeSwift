import HTTP
import Transport
import Vapor

typealias StripeClient = Client<TCPClientStream, Serializer<Request>, Parser<Response>>

public struct StripeSwift {
    
    private let authorizationHeader: String
    private let log: Log?
    
    public init?(apiKey: String, log: Log? = nil) {
        
        guard let utf8Data = apiKey.data(using: .utf8) else {
            return nil
        }
        
        self.authorizationHeader = "Basic \(utf8Data.base64EncodedString())"
        self.log = log
    }
    
    public func charges() -> JSON? {
        
        let response = try? StripeClient.get("https://api.stripe.com/v1/charges",
                                             headers: ["Authorization" : authorizationHeader]
        )
        
        if let json = response?.json {
            return json
        }
        
        log?.error("Charges failed: status \(response?.status.statusCode) \(response?.data)")
        return nil
    }
    
    public func charge(charge: Charge) -> JSON? {
        
        let response = try? StripeClient.post("https://api.stripe.com/v1/charges",
                                              headers: ["Authorization" : authorizationHeader,
                                                        "Content-Type"  : "application/x-www-form-urlencoded"],
                                              body: Body.data(charge.makeNode().formURLEncoded())
        )
        
        if let json = response?.json {
            return json
        }
        
        log?.error("Charge failed: status \(response?.status.statusCode) \(response?.data)")
        return nil
    }
}
