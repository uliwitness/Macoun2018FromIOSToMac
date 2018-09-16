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
	
	var isRoot: Bool
	
	var common: DocumentCommon? = nil
	
	init(items inItems: [ToDoRow], common: DocumentCommon?, isRoot: Bool = false) {
		items = inItems
		self.isRoot = isRoot
		self.common = common
		
		super.init(style:.plain)
	}
	
	required init?(coder aDecoder: NSCoder) {
		items = []
		isRoot = false
		
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if isRoot {
			self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissMe))
		}

		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(startEditing))
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		common?.changeHandler = {() -> Void in
			self.tableView.reloadData()
		}
	}
	
	@objc func dismissMe() {
		self.parent?.dismiss(animated: true) {
			
		}
	}
	
	@objc func startEditing() {
		self.tableView.setEditing(!self.tableView.isEditing, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, commit: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		items.remove(at: indexPath.row)
		common?.delete(item: items[indexPath.row])
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!

		cell.accessoryType = (items[indexPath.row].children.count == 0) ? .none : .disclosureIndicator

		// set the text from the data model
		cell.textLabel?.text = items[indexPath.row].text
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let subList = ListViewController(items: items[indexPath.row].children, common: common)
		self.navigationController?.pushViewController(subList, animated: true)
	}
}
