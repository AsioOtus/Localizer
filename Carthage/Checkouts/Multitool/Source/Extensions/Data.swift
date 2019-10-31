import Foundation

extension Data {
	init? (hex: String) {
		guard hex != "" else { return nil }
				
		let bytesStrings = hex.divide(fromEndBy: 2)
		var bytes = [Byte]()
		
		for byteString in bytesStrings {
			guard let byte = UInt8(byteString, radix: 16) else { return nil }
			bytes.append(byte)
		}
		
		self.init(bytes: bytes)
	}
	
	init<T> (from value: T) {
		self = Swift.withUnsafeBytes(of: value) { Data($0) }
	}
	
	func to<T> (type: T.Type) -> T {
		return self.withUnsafeBytes { $0.pointee }
	}
}

public extension Data {
	public var array: [UInt8] {
		let array = Array(self)
		return array
	}
}

extension Data: DataStringRepresentable {
	public var plainBin: String {
		return map{ $0.binRadix.padded(atStartTo: 8, with: "0") }.joined()
	}
	
	public var plainOct: String {
		return map{ $0.octRadix.padded(atStartTo: 4, with: "0") }.joined()
	}
	
	public var plainDec: String {
		return map{ $0.decRadix.padded(atStartTo: 3, with: "0") }.joined()
	}
	
	public var plainHex: String {
		return map{ $0.hexRadix.padded(atStartTo: 2, with: "0") }.joined()
	}
}
