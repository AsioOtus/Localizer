import Foundation

public extension FixedWidthInteger {
	public func grouped (fromStartBy groupSize: Int = 3, with separator: String = " ") -> String {
		return self.description.grouped(fromStartBy: groupSize, with: separator)
	}

	public func grouped (fromEndBy groupSize: Int = 3, with separator: String = " ") -> String {
		return self.description.grouped(fromEndBy: groupSize, with: separator)
	}
}

public extension FixedWidthInteger {
	public var digitsCount: Int {
		get {
			func numberOfDigits(in number: Self) -> Int {
				var result = 1
				
				if number >= 10 || number <= -10 {
					result += numberOfDigits(in: number / 10)
				}
				
				return result
			}
			
			return numberOfDigits(in: self)
		}
	}
	
	public var isEven: Bool {
		return self % 2 == 0
	}
	
	public var isOdd: Bool {
		return self % 2 != 0
	}
}

public extension FixedWidthInteger {
	public var binRadix: String {
		return String(self, radix: 2)
	}
	
	public var octRadix: String {
		return String(self, radix: 8)
	}
	
	public var decRadix: String {
		return String(self, radix: 10)
	}
	
	public var hexRadix: String {
		return String(self, radix: 16)
	}
	
	public var plainBin: String {
		return data.plainBin
	}
	
	public var plainOct: String {
		return data.plainOct
	}
	
	public var plainDec: String {
		return data.plainDec
	}
	
	public var plainHex: String {
		return data.plainHex
	}
	
	public var bin: String {
		return plainBin.grouped(fromEndBy: 8)
	}
	
	public var oct: String {
		return plainOct.grouped(fromEndBy: 4)
	}
	
	public var dec: String {
		return plainDec.grouped(fromEndBy: 3)
	}
	
	public var hex: String {
		return plainHex.grouped(fromEndBy: 2)
	}
	
	public var data: Data {
		var value = self
		let data = Data(bytes: &value, count: MemoryLayout.size(ofValue: value))
		return data
	}
}
