struct EnumDictionarySet<Enum, ValueType> where Enum: Hashable & CaseIterable {
	private var casesAppropriateValues: [Enum: ValueType] = [:]
	
	subscript (key: Enum) -> ValueType? {
		get {
			let foundedValues = casesAppropriateValues[key]
			return foundedValues
		}
		set (newValue) {
			casesAppropriateValues[key] = newValue
		}
	}
}

extension EnumDictionarySet: Sequence {
	typealias Iterator = DictionaryIterator<Enum, ValueType>
	
	func makeIterator() -> Iterator {
		return casesAppropriateValues.makeIterator()
	}
}

extension EnumDictionarySet where ValueType == Optional<Any> {
	var notEmpties: [Enum: ValueType] {
		let notEmpties = casesAppropriateValues.filter{ $0.value != nil }.mapValues{ $0! }
		return notEmpties
	}
}

extension EnumDictionarySet where ValueType: EmptyInitializable {
	init () {
		let casesValuesPairs: [(Enum, ValueType)] = Enum.allCases.map { ($0, ValueType()) }
		casesAppropriateValues = Dictionary(uniqueKeysWithValues: casesValuesPairs)
	}
}

extension EnumDictionarySet: Customizable { }
