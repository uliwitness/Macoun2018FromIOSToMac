//
//  Document.swift
//  MyShoppingListMac
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import Cocoa

class Document: NSDocument {

	var common: DocumentCommon = DocumentCommon()
	@IBOutlet weak var documentNameField: NSTextField!
	
	override var windowNibName: NSNib.Name? {
		return NSNib.Name("Document")
	}
	
	override func data(ofType typeName: String) throws -> Data {
		return try common.contents(forType: typeName) as? Data ?? Data()
	}

	override func read(from data: Data, ofType typeName: String) throws {
		self.documentNameField.stringValue = FileManager.default.displayName(atPath: self.fileURL?.path ?? "")
		try common.load(fromContents: data, ofType: typeName)
	}
}

