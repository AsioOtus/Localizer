import Foundation

public extension Numeric {
	public func grouped (with separator: String = " ", as style: NumberFormatter.Style) -> String? {
		let formatter = NumberFormatter().set {
			$0.groupingSeparator = separator
			$0.numberStyle = style
		}
		
		return formatter.string(for: self) ?? nil
	}
}
