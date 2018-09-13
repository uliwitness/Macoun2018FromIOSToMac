//
//  Document.swift
//  MyShoppingListMac
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import Cocoa

class Document: NSDocument, NSBrowserDelegate {

	var common: DocumentCommon = DocumentCommon()
	@IBOutlet weak var documentNameField: NSTextField!
	@IBOutlet weak var tableView: NSBrowser!

	override var windowNibName: NSNib.Name? {
		return NSNib.Name("Document")
	}
	
	override func windowControllerDidLoadNib(_ windowController: NSWindowController) {
		super.windowControllerDidLoadNib(windowController)
		
		self.tableView.loadColumnZero()
		
		updateUI()
	}
	
	override func data(ofType typeName: String) throws -> Data {
		return try common.contents(forType: typeName) as? Data ?? Data()
	}

	override func read(from data: Data, ofType typeName: String) throws {
		try common.load(fromContents: data, ofType: typeName)
		updateUI()
	}
	
	func updateUI() {
		guard documentNameField != nil else { return }
		
		if let docName = self.fileURL?.path {
			self.documentNameField.stringValue = FileManager.default.displayName(atPath: docName)
		}
	}
	
	public func browser(_ browser: NSBrowser, numberOfChildrenOfItem item: Any?) -> Int
	{
		if item == nil {
			return self.common.items.count
		}
		
		guard let item = item as? ToDoRow else { return 0 }
		
		return item.children.count;
	}
	
	public func browser(_ browser: NSBrowser, child index: Int, ofItem item: Any?) -> Any {
		if item == nil {
			return self.common.items[index]
		}
		
		guard let item = item as? ToDoRow else { return "" }
		
		return item.children[index];
	}
	
	
	public func browser(_ browser: NSBrowser, isLeafItem item: Any?) -> Bool {
		return false
	}
	
	public func browser(_ browser: NSBrowser, objectValueForItem item: Any?) -> Any? {
		guard let item = item as? ToDoRow else { return nil }

		return item.text
	}
}

