import Foundation

let local: Localizer

do {
	local = try Localizer.creator
		.addData(fromFilePath: "/Users/Ostap/IT/XCodeProjects/Cross-platform/Localizer/LocalizerTestGround/Localization.json")
		.create(languageProvider: .constant("ru"))
	
	print(local["login"])
	
	local.languageProvider = .constant("en")
	
	
	
	print(local["login"])
}
catch {
	print(error)
}



