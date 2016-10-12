import JSON
import Node

public struct Charge: NodeRepresentable, JSONRepresentable {
    
    public let amount: Int
    public let currency: String
    public let source: String?
    public let customer: String?
    public let description: String?
    
    public init(amount: Int, currency: String, source: String?, customer: String?, description: String?) {
        self.amount = amount
        self.currency = currency
        self.source = source
        self.customer = customer
        self.description = description
    }
    
    public func makeNode(context: Context) throws -> Node {
        
        var dict = [
            "amount"        : amount,
            "currency"      : currency
        ] as [String : NodeRepresentable]
        
        if let source = source {
            dict["source"] = source
        }
        
        if let customer = customer {
            dict["customer"] = customer
        }
        
        if let description = description {
            dict["description"] = description
        }
        
        return try Node(node: dict)
    }
}
