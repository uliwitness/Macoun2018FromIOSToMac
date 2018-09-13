//
//  UIView.swift
//  MyShoppingList
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import Cocoa

class UIColor: NSColor {
	
}

class UIView: NSView {
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		
		self.wantsLayer = true
	}

	required init?(coder decoder: NSCoder) {
		super.init(coder: decoder)
		
		self.wantsLayer = true
	}
	
	func setNeedsDisplay() {
		setNeedsDisplay(self.bounds)
	}

	override func mouseDown(with event: NSEvent) {
		touchesBegan(Set<UITouch>(), with: event)
	}

	override func mouseUp(with event: NSEvent) {
		touchesEnded(Set<UITouch>(), with: event)
	}
	
	func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
	}

	func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
	}
}


func UIGraphicsGetCurrentContext() -> CGContext? {
	return NSGraphicsContext.current?.cgContext
}

typealias UITouch = NSObject

typealias UIEvent = NSEvent
