import JSON
import Node

public struct Charge: NodeRepresentable, JSONRepresentable {
    
    public let amount: Int
    public let currency: String
    public let source: String
    public let description: String?
    
    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "amount"        : amount,
            "currency"      : currency,
            "source"        : source,
            "description"   : description
            ])
    }
    
    public func makeJSON() throws -> JSON {
        return try JSON(node: makeNode())
    }
}
