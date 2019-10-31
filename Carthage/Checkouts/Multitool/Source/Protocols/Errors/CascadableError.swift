public protocol CascadableError: DescribableError {
	var innerError: Error? { get }
	var allMessages: [String] { get }
	var fullDescription: String { get }
}

public extension CascadableError {
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
	
	private func allJoinedMessages () -> [String] {
		var innerMessages = [String]()
		
		if let innerError = self.innerError as? CascadeError {
			innerMessages = innerError.allMessages
		} else if let innerError = self.innerError {
			innerMessages += innerError.localizedDescription
		}
		
		return [localizedDescription] + innerMessages
	}
}
