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
            "GridViewController"
        ]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewControllers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let viewController = viewControllers[indexPath.row]
        cell.textLabel?.text = viewController
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = viewControllers[indexPath.row]
        let vc = storyboard!.instantiateViewController(identifier: viewController)
        navigationController?.pushViewController(vc, animated: true)
    }

}
