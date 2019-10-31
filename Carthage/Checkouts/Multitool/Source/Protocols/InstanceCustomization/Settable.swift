public protocol Settable { }

public extension Settable where Self: Any {
	public mutating func mutableSet (_ block: (inout Self) throws -> Void) rethrows -> Self {
		try block(&self)
		return self
	}
	
	public func set (_ block: (inout Self) throws -> Void) rethrows -> Self {
		var selfCopy = self
		try block(&selfCopy)
		return selfCopy
	}
}

public extension Settable where Self: AnyObject {
	public func set (_ block: (Self) throws -> Void) rethrows -> Self {
		try block(self)
		return self
	}
}
