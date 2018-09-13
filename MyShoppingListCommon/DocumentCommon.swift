//
//  DocumentCommon.swift
//  MyShoppingList
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import Foundation

class DocumentCommon
{
	var text = "This is a new document. Write in it."
	
	func contents(forType typeName: String) throws -> Any {
		return self.text.data(using: .utf8) as Any
	}
	
	func load(fromContents contents: Any, ofType typeName: String?) throws {
		if let contents = contents as? Data {
			self.text = String(data: contents, encoding: .utf8) ?? ""
		}
	}
}
