//
//  DocumentCommon.swift
//  MyShoppingList
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import Foundation

class ToDoRow {
	var text: String
	var children: [ToDoRow]
	
	init(_ inText: String, children inKids: [ToDoRow] = []) {
		text = inText
		children = inKids
	}
}

class DocumentCommon
{
	var text = "This is a new document. Write in it."
	
	var items: [ToDoRow] = [
		ToDoRow("Babylon 5", children:
			[
				ToDoRow("Lyta Alexander"),
				ToDoRow("Jeffrey Sinclair"),
				ToDoRow("Susan Ivanova"),
				ToDoRow("Londo Mollari"),
				ToDoRow("Talia Winters"),
				ToDoRow("Vir Cotto"),
				ToDoRow("Delenn"),
				ToDoRow("Lennier"),
				ToDoRow("Lise Hampton"),
				ToDoRow("Lord Refa"),
				ToDoRow("Dureena Nafeel"),
				ToDoRow("G'Kar"),
				ToDoRow("Elizabeth Lochley")
			]),
		ToDoRow("Star Trek", children:
			[
				ToDoRow("Deanna Troi"),
				ToDoRow("Jean-Luc Picard"),
				ToDoRow("Katherine Pulaski"),
				ToDoRow("Miles O'Brien"),
				ToDoRow("Ro Laren"),
				ToDoRow("Data"),
				ToDoRow("Tasha Yar"),
				ToDoRow("Worf"),
				ToDoRow("K'Ehleyr"),
				ToDoRow("Thomas Riker"),
				ToDoRow("Eri Dax"),
			]
		),
	]
	
	func contents(forType typeName: String) throws -> Any {
		return self.text.data(using: .utf8) as Any
	}
	
	func load(fromContents contents: Any, ofType typeName: String?) throws {
		if let contents = contents as? Data {
			self.text = String(data: contents, encoding: .utf8) ?? ""
		}
	}
}
