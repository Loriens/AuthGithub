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
    
    let sharedSession = URLSession.shared
    var repos = ""
    var language = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Скрывает клавиатуру при нажатии на экран вне UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch {
            view.endEditing(true)
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        if let repos = repositoryField.text {
            self.repos = repos
        }
        if let language = languageField.text {
            self.language = language
        }
        var sortOrder = "asc"
        
        if sortSearchControl.selectedSegmentIndex == 1 {
            sortOrder = "desc"
        }
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(repos)+language:\(language)&sort=stars&order=\(sortOrder)") else {
            print("url is empty")
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = sharedSession.dataTask(with: request) { (data, respons, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                print("no data received")
                return
            }
            
            guard let text = String(data: data, encoding: .utf8) else {
                print("data encoding failed")
                return
            }
            
            print(text)
        }
        
        dataTask.resume()
    }

}
