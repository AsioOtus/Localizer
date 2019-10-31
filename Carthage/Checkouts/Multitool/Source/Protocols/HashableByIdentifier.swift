public protocol HashableByIdentifier: Hashable, Identifiable { }

public extension HashableByIdentifier {
	var hashValue: Int {
		return Int(id)
	}
	
	static func == (_ left: Self, _ right: Self) -> Bool {
		return left.id == right.id
	}
}
