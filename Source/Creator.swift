import Foundation

public extension Localizer {
	class Creator {
		public enum Error: Swift.Error {
			case jsonParsingFailure
			case dataAdditionFailure(url: URL, error: Swift.Error)
		}
		
		private var storages = [Storage]()
		
		public func addData (fromFilePath filePath: String) throws -> Creator {
			let url = URL(fileURLWithPath: filePath)
			try addData(from: url)
			return self
		}
		
		public func create (languageProvider: LanguageProvider) -> Localizer {
			let localizer = Localizer(languageProvider: languageProvider, storages: storages)
			storages.removeAll()
			return localizer
		}
		
		private func addData (from url: URL) throws {
			do {
				let data = try Data(contentsOf: url)
				let newStorages = try parse(data)
				
				storages.append(contentsOf: newStorages)
			} catch {
				throw Creator.Error.dataAdditionFailure(url: url, error: error)
			}
		}
		
		private func parse (_ data: Data) throws -> [Storage] {
			let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
			
			if let rawRecords = jsonData as? [String: [String: [String: String]]] {
				let storages = rawRecords.map { storageName, records in
					Storage(
						key: storageName,
						records: records.map { recordKey, translations in
							Record(key: recordKey, translations: translations)
						}
					)
				}
				
				return storages
			} else {
				throw Creator.Error.jsonParsingFailure
			}
		}
	}
}
