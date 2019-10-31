public protocol DetalizableError: CascadableError {
	associatedtype DetailsType
	
	var details: DetailsType { get }
}
