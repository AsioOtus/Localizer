public protocol Transformable { }

public extension Transformable where Self: Any {
	public mutating func mutableTransform<T> (_ block: (inout Self) throws -> T) rethrows -> T {
		let result = try block(&self)
		return result
	}
	
	public func transform<T> (_ block: (inout Self) throws -> T) rethrows -> T {
		var selfCopy = self
		let result = try block(&selfCopy)
		return result
	}
}

public extension Transformable where Self: AnyObject {
	public func transform<T> (_ block: (Self) throws -> T) rethrows -> T {
		let result = try block(self)
		return result
	}
}
