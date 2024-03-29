public protocol ExpressibleByInt { }

public extension ExpressibleByInt where Self: CaseIterable {
	public init (int: Int) {
		let normilizedInt = int % Self.allCases.count
		let resultDirection = Self.allCases[Self.allCases.index(Self.allCases.startIndex, offsetBy: normilizedInt)]
		self = resultDirection
	}
}
