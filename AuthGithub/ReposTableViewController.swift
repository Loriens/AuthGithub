//
//  ReposTableViewController.swift
//  AuthGithub
//
//  Created by Vladislav on 05/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    private let reuseIdentifier = "ReposCell"
    var repositories: [Repository]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ReposTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        self.tableView.allowsSelection = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let repos = repositories else {
            return 0
        }
        
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ReposTableViewCell
        
        cell.congigure(with: repositories![indexPath.item])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: self.tableView.frame.width - 10, height: 60))
        label.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
        label.text = "Repositories found: \(repositories!.count)"
        
        view.addSubview(label)
        view.sizeToFit()
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }

}
