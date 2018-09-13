//
//  CustomView.swift
//  MyShoppingList
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

#if MYSHOPPINGLIST_IOS
import UIKit
#else
import Cocoa
#endif

class CustomView: UIView
{
	var currColor = UIColor.red
	
	override func draw(_ frame: CGRect) {
		let ctx = UIGraphicsGetCurrentContext()
		
		ctx?.setFillColor(self.currColor.cgColor)
		ctx?.fill(self.bounds)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.currColor = UIColor.darkGray
		setNeedsDisplay()
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let currTouch = touches.first {
			let pos = currTouch.location(in: self)
			
			if self.bounds.contains(pos) {
				self.currColor = UIColor.darkGray
			} else {
				self.currColor = UIColor.red
			}
			setNeedsDisplay()
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.currColor = UIColor.red
		setNeedsDisplay()
	}
}
