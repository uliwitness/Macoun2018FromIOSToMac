//
//  DocumentViewController.swift
//  MyShoppingList
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
	@IBOutlet weak var documentNameLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!

	let cellReuseIdentifier = "SimpleCell"
    var document: Document?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
	}
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return document!.common.items.count
	}
	
	// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
	// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
		
		// set the text from the data model
		cell.textLabel?.text = document!.common.items[indexPath.row].text
		
		return cell
	}
	
	@IBAction func showNavView(_ sender: Any) {
		let navView = UINavigationController(rootViewController: ListViewController(items: document!.common.items, common: document!.common, isRoot: true))
		self.present(navView, animated: true) {
			
		}
	}
}
