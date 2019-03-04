//
//  ViewController.swift
//  AuthGithub
//
//  Created by Vladislav on 03/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit
import Kingfisher

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoURL = URL(string: "https://i2.wp.com/www.globalemancipation.ngo/wp-content/uploads/2017/09/github-logo.png")
        logoView.kf.setImage(with: logoURL)
    }

    @IBAction func loginPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userVC = storyboard.instantiateViewController(withIdentifier: "userViewController")
        
        navigationController?.pushViewController(userVC, animated: true)
    }
    
}

