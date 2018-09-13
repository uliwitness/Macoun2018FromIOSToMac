//
//  Document.swift
//  MyShoppingList
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import UIKit

class Document: UIDocument {
	
	var common: DocumentCommon = DocumentCommon()
	
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return try common.contents(forType: typeName)
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        try common.load(fromContents: contents, ofType: typeName)
    }
}

