//
//  AppDelegate.swift
//  MyShoppingListMac
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet var popoverView: NSView!
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
	@IBAction func delete( _ sender: Any) {
		let alert = NSAlert()
		alert.messageText = "Tu was, App Delegate!"
		alert.informativeText = "Willst nicht?"
		alert.addButton(withTitle: "Jaja...")
		let button = alert.runModal()
		if button == .alertFirstButtonReturn {
			print("OK.")
		}
	}
}

