public protocol Randomable {
	associatedtype T
	static var random: T { get }
}

public extension Randomable where Self: ExpressibleByInt & CaseIterable {
	public static var random: Self {
		return Self(int: Int.random(in: 0..<Self.allCases.count))
	}
}
