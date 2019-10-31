public protocol LanguageProviderProtocol {
	func currentLanguageKey () -> LanguageKey
}

public extension Localizer {
	enum LanguageProvider {
		case constant (LanguageKey)
		case function (() -> (LanguageKey))
		case object (LanguageProviderProtocol)
		
		internal func currentLanguageKey () -> LanguageKey {
			let currentLanguageKey: LanguageKey
			
			switch self {
			case .constant(let constant):
				currentLanguageKey = constant
			case .function(let function):
				currentLanguageKey = function()
			case .object(let object):
				currentLanguageKey = object.currentLanguageKey()
			}
			
			return currentLanguageKey
		}
	}
}
