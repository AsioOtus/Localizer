public protocol DescribableError: Error, CustomStringConvertible, Customizable {
	var description: String { get }
	var localizedDescription: String { get }
}

public extension DescribableError {	
	var localizedDescription: String {
		return description
	}
}
