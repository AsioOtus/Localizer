import Foundation

// MARK: Padding
public extension String {
	public static let defaultPaddingFillString: String = " "

	public func padded (atStartTo length: Int) -> String {
		return createPadString(length, String.defaultPaddingFillString) + self
	}

	public func padded (atEndTo length: Int) -> String {
		return self + createPadString(length, String.defaultPaddingFillString)
	}

	public func padded (atStartTo length: Int, with fillString: String, cutPadFrom paddingCutEdge: Edge = .start) -> String {
		return createPadString(length, fillString, paddingCutEdge) + self
	}

	public func padded (atEndTo length: Int, with fillString: String, cutPadFrom paddingCutEdge: Edge = .end) -> String {
		return self + createPadString(length, fillString, paddingCutEdge)
	}

	private func createPadString (_ length: Int, _ fillString: String, _ paddingCutEdge: Edge) -> String {
		var resultPadString = ""

		guard count < length else { return resultPadString }

		let padLength = length - count
		let padString = createPadString(length, fillString)

		resultPadString = paddingCutEdge == .start
			? String(padString.suffix(padLength))
			: String(padString.prefix(padLength))

		return resultPadString
	}

	private func createPadString (_ length: Int, _ fillString: String) -> String {
		var padString = ""

		guard count < length else { return padString }

		let padLength = length - count
		padString = fillString

		if padLength > fillString.count {
			while padString.count < padLength {
				padString.append(fillString)
			}
		}

		return padString
	}
}

public extension String {
	public static let defaultGroupSeparator = " "

	public func grouped (fromStartBy groupSize: Int, with separator: String = defaultGroupSeparator) -> String {
		return self.divide(fromStartBy: groupSize).joined(separator: separator)
	}

	public func grouped (fromEndBy groupSize: Int, with separator: String = defaultGroupSeparator) -> String {
		return self.divide(fromEndBy: groupSize).joined(separator: separator)
	}
	
	public func divide (fromStartBy groupSize: Int) -> [String] {
		return self.divide(by: groupSize)
	}
	
	public func divide (fromEndBy groupSize: Int) -> [String] {
		return self.reversed.divide(by: groupSize).map{ $0.reversed }.reversed()
	}
	
	private func divide (by groupSize: Int) -> [String] {
		guard groupSize > 0 else { return [self] }
		
		var i = 0
		var groupString = ""
		var resultArray = [String]()
		
		for character in self {
			if i == groupSize {
				resultArray += groupString
				
				groupString = ""
				i = 0
			}
			
			groupString += String(character)
			i += 1
		}
		
		if groupString != "" {
			resultArray += groupString
		}
		
		return resultArray
	}
}

public extension String {
	private func insert (_ string: String, forEachPosition positionNumber: Int) -> String {
		var characterCounter = 0
		var resultString = ""

		for character in self {
			resultString += String(character)
			characterCounter += 1

			if characterCounter == positionNumber {
				resultString += string
				characterCounter = 0
			}
		}

		return resultString
	}

	public var removedFirst: String {
		guard self.count > 0 else { return self }
		
		var resultString = self
		resultString.removeFirst()
		return resultString
	}
	
	public var removedLast: String {
		guard self.count > 0 else { return self }
		
		var resultString = self
		resultString.removeLast()
		return resultString
	}

	public var reversed: String {
		return String(self.reversed())
	}
}

public extension String {
	public subscript (safe offset: Int) -> Character? {
		guard let resultIndex = self.index(self.startIndex, offsetBy: offset, limitedBy: self.endIndex) else { return nil }
		return self[resultIndex]
	}
	
	public func index (at offset: Int) -> String.Index? {
		return self.index(self.startIndex, offsetBy: offset, limitedBy: self.endIndex)
	}
}

public extension String {
	public var base64Encoded: String {
		let encodedString = self.data(using: .utf8)!.base64EncodedString()
		return encodedString
	}
	
	public var base64Decoded: String? {
		guard let stringData = Data(base64Encoded: self) else { return nil }
		let decodedString = String(data: stringData, encoding: .utf8)
		return decodedString
	}
	
	public init? (base64 string: String) {
		guard let decodedString = string.base64Decoded else { return nil }
		self = decodedString
	}
	
	public init? (toBase64 string: String) {
		self = string.base64Encoded
	}
}
	
extension String: DataStringRepresentable {
	public var plainBin: String {
		let result = self.data(using: .utf8)!.plainBin
		return result
	}
	
	public var plainOct: String {
		let result = self.data(using: .utf8)!.plainOct
		return result
	}
	
	public var plainDec: String {
		let result = self.data(using: .utf8)!.plainDec
		return result
	}
	
	public var plainHex: String {
		let result = self.data(using: .utf8)!.plainHex
		return result
	}
}
