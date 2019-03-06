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
        
        // Округление avatarView
        self.avatarView.layer.masksToBounds = true
//        self.avatarView.layer.cornerRadius = self.avatarView.frame.width / 2
    }
    
    // Скрывает клавиатуру при нажатии на экран вне UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first as? UITouch {
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
        
        let dataTask = sharedSession.dataTask(with: request) { (data, responce, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                print("no data received")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // Достаём все репозитории
                guard let items = json!["items"] as? Array<Any> else {
                    print("items are not found")
                    return
                }
                
                var repositories = [Repository]()
                
                for item in items {
                    guard let item = item as? [String: Any] else {
                        print("cannot convert item to dictionary")
                        return
                    }
                    repositories.append(Repository(json: item)!)
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ReposTableVC = storyboard.instantiateViewController(withIdentifier: "ReposTableVC") as! ReposTableViewController
                
                DispatchQueue.main.async {
                    ReposTableVC.repositories = repositories
                    
                    self.navigationController?.pushViewController(ReposTableVC, animated: true)
                }
            } else {
                print("cannot create object form JSON")
            }
        }
        
        dataTask.resume()
    }

}
