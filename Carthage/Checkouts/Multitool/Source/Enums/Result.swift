import Foundation

public enum Result<T> {
	case success(T)
	case failure(Error)
}

extension Result: Customizable { }
