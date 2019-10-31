public struct Storage {
	public let key: StorageKey
	public let records: [Record]
	
	internal init (key: StorageKey, records: [Record]) {
		self.key = key
		self.records = records
	}
	
	public subscript (_ recordKey: RecordKey) -> Record? {
		return records.first{ $0.key == recordKey }
	}
}
