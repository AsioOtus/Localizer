open class CascadeError: DescribedError, CascadableError {
	public let innerError: Error?
	
	public var allMessages: [String] {
		return allJoinedMessages()
	}
	
	public var fullDescription: String {
		func addIndentation (for string: String, size: Int) -> String {
			let indentationString = String(repeating: "\t", count: size)
			return string.split(separator: "\n").map{ indentationString + $0 }.joined(separator: "\n")
		}
		
		return allMessages.enumerated().map{ addIndentation(for: $0.element, size: $0.offset) }.joined(separator: "\n\n")
	}
	
	public init (_ description: String, _ innerError: Error? = nil) {
		self.innerError = innerError
		
		super.init(description)
	}
	
	private func allJoinedMessages () -> [String] {
		var innerMessages = [String]()
		
		if let innerError = self.innerError as? CascadeError {
			innerMessages = innerError.allJoinedMessages()
		} else if let innerError = self.innerError {
			innerMessages += innerError.localizedDescription
		}
		
		return [localizedDescription] + innerMessages
	}
}
