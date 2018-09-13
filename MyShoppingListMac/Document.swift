//
//  Document.swift
//  MyShoppingListMac
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import Cocoa

class Document: NSDocument, NSTableViewDelegate, NSTableViewDataSource {

	var common: DocumentCommon = DocumentCommon()
	@IBOutlet weak var documentNameField: NSTextField!
	@IBOutlet weak var tableView: NSTableView!

	override var windowNibName: NSNib.Name? {
		return NSNib.Name("Document")
	}
	
	override func windowControllerDidLoadNib(_ windowController: NSWindowController) {
		super.windowControllerDidLoadNib(windowController)
		
		self.tableView.reloadData()
		
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
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return common.items.count
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		let tableCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue:"SimpleCell"), owner: self)
		if let tableCell = tableCell as? NSTableCellView {
			tableCell.textField?.stringValue = common.items[row]
		}
		return tableCell
	}
}

