open class DescribedError: DescribableError {
	public let description: String
	
	public var localizedDescription: String {
		return description
	}
	
	public init (_ description: String) {
		self.description = description
	}
}

extension DescribedError: Customizable { }
