public protocol ClosureInitializable { }

public extension ClosureInitializable where Self: Any & EmptyInitializable {
	public init (_ block: (inout Self) throws -> Void) rethrows {
		self.init()
		try block(&self)
	}
}

public extension ClosureInitializable where Self: AnyObject & EmptyInitializable {
	public init (_ block: (Self) throws -> Void) rethrows {
		self.init()
		try block(self)
	}
}
