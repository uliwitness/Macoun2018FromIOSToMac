//
//  InspectorController.swift
//  MyShoppingListMac
//
//  Created by Uli Kusterer on 16.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import AppKit

@objc protocol InspectorControllerTarget {
	var currentNameForInspector: String? { get set }
}

@objc class InspectorController: NSObject, NSTextFieldDelegate, NSPopoverDelegate {
	@IBOutlet var inspectorWindow: NSWindow! = nil
	@IBOutlet var nameField: NSTextField! = nil
	var popover = NSPopover()

	static var shared: InspectorController! = nil
	
	override init() {
		super.init()
		InspectorController.shared = self
	}
	
	override func awakeFromNib() {
		NotificationCenter.default.addObserver(self, selector: #selector(mainWindowDidChange(_:)), name: NSWindow.didBecomeMainNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(mainWindowDidChange(_:)), name: NSWindow.didResignMainNotification, object: nil)
	}
	
	func updateUI() {
		if let target = NSApplication.shared.target(forAction: #selector(getter: InspectorControllerTarget.currentNameForInspector)) as? InspectorControllerTarget {
			self.nameField.stringValue = target.currentNameForInspector ?? ""
			self.nameField.isEnabled = true
		} else {
			self.nameField.stringValue = ""
			self.nameField.isEnabled = false
		}
	}
	
	@objc func mainWindowDidChange(_ notification: NSNotification) {
		updateUI()
	}
	
	@objc func controlTextDidChange(_ obj: Notification) {
		if let target = NSApplication.shared.target(forAction: #selector(getter: InspectorControllerTarget.currentNameForInspector)) as? InspectorControllerTarget {
			target.currentNameForInspector = self.nameField.stringValue
		}
	}
	
	@IBAction func orderFrontPopover( _ sender: Any ) {
		guard let senderView = sender as? NSView else { return }
		
		if popover.isShown && !popover.isDetached {
			popover.close()
		} else {
			if popover.isDetached { // User lost detached popover behind another window or so?
				popover.close() // Close detached popover (async)
				popover = NSPopover() // Make a new popover so we immediately open the popover, re-attached and the user knows where it is again.
			}
			
			popover.behavior = .transient
			popover.delegate = self
			popover.contentViewController = PopoverViewController(nibName: "PopoverViewController", bundle: nil)
			popover.show(relativeTo: senderView.bounds, of: senderView, preferredEdge: .maxX)
		}
	}
	
	func popoverShouldDetach(_ popover: NSPopover) -> Bool {
		return true
	}
}
