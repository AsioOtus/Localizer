public protocol Usable { }

public extension Usable where Self: Any {
	public mutating func mutableUse (_ block: (inout Self) throws -> Void) rethrows {
		try block(&self)
	}
	
	public func use (_ block: (inout Self) throws -> Void) rethrows {
		var selfCopy = self
		try block(&selfCopy)
	}
}

public extension Usable where Self: AnyObject {
	public func use (_ block: (Self) throws -> Void) rethrows {
		try block(self)
	}
}
