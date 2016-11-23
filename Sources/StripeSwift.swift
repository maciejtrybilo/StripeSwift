import HTTP
import Transport
import Vapor
import Foundation

typealias StripeClient = FoundationClient
//typealias StripeClient = Client<TCPClientStream, Serializer<Request>, Parser<Response>>

public struct StripeSwift {
    
    private let authorizationHeader: String
    private let log: LogProtocol?
    
    public init?(apiKey: String, log: LogProtocol? = nil) {
        
        self.authorizationHeader = "Bearer \(apiKey)"
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
