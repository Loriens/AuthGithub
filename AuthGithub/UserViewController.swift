//
//  UserViewController.swift
//  AuthGithub
//
//  Created by Vladislav on 04/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var repositoryField: UITextField!
    @IBOutlet weak var languageField: UITextField!
    @IBOutlet weak var sortSearchControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchPressed(_ sender: Any) {
    }

}
