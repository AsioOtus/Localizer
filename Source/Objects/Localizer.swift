// MARK: Creator instance
public extension Localizer {
	static let creator = Creator()
}

// MARK: Class definition
public class Localizer {
	public var languageProvider: LanguageProvider
	
	private let storages: [Storage]
	
	internal init (languageProvider: LanguageProvider, storages: [Storage]) {
		self.languageProvider = languageProvider
		self.storages = storages
	}
}

// MARK: Localization data getter
private extension Localizer {
	func findRecord (_ storages: [Storage], _ recordKey: RecordKey) -> Record? {
		for storage in storages {
			if let record = storage[recordKey] {
				return record
			}
		}
		
		return nil
	}
	
	func findTranslation (_ storages: [Storage], _ recordKey: RecordKey) -> Translation? {
		guard let record = findRecord(storages, recordKey) else { return nil }
		guard let translation = record[languageProvider.currentLanguageKey()] else { return nil }
		return translation
	}
	
	func findTranslation (_ recordKey: RecordKey) -> Translation? {
		return findTranslation(storages, recordKey)
	}
	
	func findTranslation (_ storageKey: StorageKey, _ recordKey: RecordKey) -> Translation? {
		guard let storage = storages.first(where: { $0.key == storageKey }) else { return nil }
		return findTranslation([storage], recordKey)
	}
	
	func preparedTranslation (_ recordKey: RecordKey) -> Translation {
		return findTranslation(recordKey) ?? ""
	}
	
	func preparedTranslation (_ storageName: String, _ recordKey: RecordKey) -> Translation {
		return findTranslation(storageName, recordKey) ?? ""
	}
}

// MARK: Public function interface
public extension Localizer {
	func translation (_ recordKey: RecordKey) -> Translation {
		return preparedTranslation(recordKey)
	}
	
	func translation (_ recordKeyObject: RecordKeyProtocol) -> Translation {
		return preparedTranslation(recordKeyObject.recordKey)
	}
	
	func translation (_ storageKey: StorageKey, _ recordKey: RecordKey) -> Translation {
		return preparedTranslation(storageKey, recordKey)
	}
	
	func translation (_ storageKey: StorageKey, _ recordKeyObject: RecordKeyProtocol) -> Translation {
		return preparedTranslation(storageKey, recordKeyObject.recordKey)
	}
	
	func translation (_ storageKeyObject: StorageKeyProtocol, _ recordKey: RecordKey) -> Translation {
		return preparedTranslation(storageKeyObject.storageKey, recordKey)
	}
	
	func translation (_ storageKeyObject: StorageKeyProtocol, _ recordKeyObject: RecordKeyProtocol) -> Translation {
		return preparedTranslation(storageKeyObject.storageKey, recordKeyObject.recordKey)
	}
	
}

// MARK: Public subscript interface
public extension Localizer {
	subscript (_ recordKey: RecordKey) -> Translation {
		return preparedTranslation(recordKey)
	}
	
	subscript (_ recordKeyObject: RecordKeyProtocol) -> Translation {
		return preparedTranslation(recordKeyObject.recordKey)
	}
	
	subscript (_ storageKey: StorageKey, _ recordKey: RecordKey) -> Translation {
		return preparedTranslation(storageKey, recordKey)
	}
	
	subscript (_ storageKey: StorageKey, _ recordKeyObject: RecordKeyProtocol) -> Translation {
		return preparedTranslation(storageKey, recordKeyObject.recordKey)
	}
	
	subscript (_ storageKeyObject: StorageKeyProtocol, _ recordKey: RecordKey) -> Translation {
		return preparedTranslation(storageKeyObject.storageKey, recordKey)
	}
	
	subscript (_ storageKeyObject: StorageKeyProtocol, _ recordKeyObject: RecordKeyProtocol) -> Translation {
		return preparedTranslation(storageKeyObject.storageKey, recordKeyObject.recordKey)
	}
}
