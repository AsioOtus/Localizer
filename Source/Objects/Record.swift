public struct Record {
	public let key: RecordKey
	public let translations: [LanguageKey: Translation]
	
	public init (key: RecordKey, translations:[LanguageKey: Translation]) {
		self.key = key
		self.translations = translations
	}
	
	public subscript (languageKey: LanguageKey) -> Translation? {
		return translations[languageKey]
	}
}
