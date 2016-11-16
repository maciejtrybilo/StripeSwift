import HTTP
import Transport
import Vapor

typealias StripeClient = FoundationClient//Client<TCPClientStream, Serializer<Request>, Parser<Response>>

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
        
        do {
            let response = try StripeClient.get("https://api.stripe.com/v1/charges",
                                                headers: ["Authorization" : authorizationHeader]
            )
            
            return response.json
            
        } catch let error {
            log?.error("Charges failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func charge(charge: Charge) -> JSON? {
        
        do {
            let response = try StripeClient.post("https://api.stripe.com/v1/charges",
                                                 headers: ["Authorization" : authorizationHeader,
                                                           "Content-Type"  : "application/x-www-form-urlencoded"],
                                                 body: Body.data(charge.makeNode().formURLEncoded())
            )
            
            return response.json
            
        } catch let error {
            log?.error("Charge failed: \(error.localizedDescription)")
            return nil
        }
    }
}
