import Foundation

public class Event<T> {
	public typealias Handler = (T) -> ()
	
	public private(set) var handlers = [String: Handler]()
	
	public required init () { }
	
	public func getHandler (byKey key: String) -> Handler? {
		return handlers[key]
	}
	
	public func addHandler (key: String? = nil, handler: @escaping Handler) -> (key: String, isAdded: Bool) {
		let key = key ?? UUID().uuidString
		
		let notContains = !contains(key: key)
		
		if notContains {
			handlers[key] = handler
		}
		
		return (key, notContains)
	}
	
	public func updateHandler (byKey key: String, handler: @escaping Handler) -> Bool {
		let isContains = contains(key: key)
		
		if isContains {
			handlers[key] = handler
		}
		
		return isContains
	}
	
	public func removeHandler (by key: String) -> Bool {
		let isContains = contains(key: key)
		
		if isContains {
			handlers.removeValue(forKey: key)
		}
		
		return isContains
	}
	
	public func contains (key: String) -> Bool {
		return handlers[key] != nil
	}
	
	public func clear () {
		handlers.removeAll()
	}
	
	public func raise (withData data: T) {
		for (_, handler) in handlers {
			handler(data)
		}
	}
	
	public static func += (event: Event, handler: @escaping Handler) {
		_ = event.addHandler(handler: handler)
	}
	
	public static func += (event: Event, handler: (key: String, block: Handler)) {
		_ = event.addHandler(handler: handler.block)
	}
}

extension Event: Customizable, ClosureInitializable { }
