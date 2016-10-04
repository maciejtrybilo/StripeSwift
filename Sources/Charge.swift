import JSON
import Node

public struct Charge: NodeRepresentable, JSONRepresentable {
    
    public let amount: Int
    public let currency: String
    public let source: String
    public let description: String?
    
    public init(amount: Int, currency: String, source: String, description: String?) {
        self.amount = amount
        self.currency = currency
        self.source = source
        self.description = description
    }
    
    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "amount"        : amount,
            "currency"      : currency,
            "source"        : source,
            "description"   : description
            ])
    }
}
