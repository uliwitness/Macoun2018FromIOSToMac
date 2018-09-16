//
//  Document.swift
//  MyShoppingListMac
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import Cocoa

class Document: NSDocument, NSOutlineViewDataSource, NSOutlineViewDelegate {

	var common: DocumentCommon = DocumentCommon()
	@IBOutlet weak var documentNameField: NSTextField!
	@IBOutlet weak var tableView: NSOutlineView!

	override var windowNibName: NSNib.Name? {
		return NSNib.Name("Document")
	}
	
	override func windowControllerDidLoadNib(_ windowController: NSWindowController) {
		super.windowControllerDidLoadNib(windowController)
		
		common.changeHandler = {() -> Void in
			self.tableView.reloadData()
		}
		
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
	
	func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int
	{
		if item == nil {
			return self.common.items.count
		}
		
		guard let item = item as? ToDoRow else { return 0 }
		
		return item.children.count;
	}

	func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
		if item == nil {
			return self.common.items[index]
		}
		
		guard let item = item as? ToDoRow else { return "" }
		
		return item.children[index];
	}

	func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
		guard let item = item as? ToDoRow else { return false }
		
		return item.children.count > 0;
	}
	
	func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
		guard let item = item as? ToDoRow else { return nil }

		let tableCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue:"SimpleCell"), owner: self)
		if let tableCell = tableCell as? NSTableCellView {
			tableCell.textField?.stringValue = item.text
		}
		return tableCell
	}
	
	override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
		if menuItem.action == #selector(delete(_:)) {
			return self.tableView.selectedRow != -1
		} else {
			return true
		}
	}
	
	@IBAction func delete(_ sender: Any) {
		let selRowIndex = self.tableView.selectedRow
		
		guard selRowIndex >= 0 else { return }
		
		if let selectedItem = self.tableView.item(atRow: selRowIndex) as? ToDoRow {
			common.delete(item: selectedItem)
		}
	}
}

