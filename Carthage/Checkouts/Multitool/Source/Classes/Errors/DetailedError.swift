open class DetailedError<DetailsType>: CascadeError, DetalizableError {
	public let details: DetailsType
	
	public init (_ description: String, details: DetailsType, _ innerError: Error? = nil) {
		self.details = details
		
		super.init(description, innerError)
	}
}
