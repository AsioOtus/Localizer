public extension Array {
	public static func + (left: Array, right: Element) -> Array {
		return left + [right]
	}
	
	public static func += (left: inout Array, right: Element) {
		left.append(right)
	}
}
