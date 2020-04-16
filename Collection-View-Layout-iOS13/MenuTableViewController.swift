//
//  MenuTableViewController.swift
//  Collection-View-Layout-iOS13
//
//  Created by atikhonov on 04.04.2020.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var viewControllers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            "ListViewController",
            "GridViewController",
            "TwoColumnViewController",
            "InsetItemsGridViewController",
            "DistinctSectionsViewController",
            "AdaptiveSectionsViewController",
            "NestedGroupsViewController",
            "AppStoreViewController"
        ]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewControllers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let viewController = viewControllers[indexPath.row]
        let name: String = self.name(from: viewController)
        cell.textLabel?.text = name
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = viewControllers[indexPath.row]
        let vc = storyboard!.instantiateViewController(identifier: viewController)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private methods
    
    
    private func name(from viewController: String) -> String {
        // "ListViewController" -> "List View Controller"
        var result = ""
        for c in viewController {
            if c.isUppercase {
                result.append(" ")
            }
            result.append(c)
        }
        return result
    }

}
