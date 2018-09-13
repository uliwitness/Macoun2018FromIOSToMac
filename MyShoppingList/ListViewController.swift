//
//  ListViewController.swift
//  MyShoppingList
//
//  Created by Uli Kusterer on 13.09.18.
//  Copyright © 2018 Uli Kusterer. All rights reserved.
//

import UIKit


class ListViewController: UITableViewController
{
	let cellReuseIdentifier = "SimpleCell"
	
	var items: [ToDoRow]
	
	init(items inItems: [ToDoRow]) {
		items = inItems
		
		super.init(style:.plain)
	}
	
	required init?(coder aDecoder: NSCoder) {
		items = []
		
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissMe))
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
	}
	
	@objc func dismissMe() {
		self.parent?.dismiss(animated: true) {
			
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
		
		// set the text from the data model
		cell.textLabel?.text = items[indexPath.row].text
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let subList = ListViewController(items: items[indexPath.row].children)
		self.navigationController?.pushViewController(subList, animated: true)
	}
}
