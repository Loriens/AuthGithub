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
        // Ссылка на получение информации о пользователе
        guard let baseURL = URL(string: "https://api.github.com/user") else {
            return
        }
        
        guard let username = usernameField.text,
            let password = passwordField.text else {
            print("Enter username and password")
            return
        }
        
        var request = URLRequest (url: baseURL)
        request.httpMethod = "GET"
        let loginString = username + ":" + password
        // В запросе передаём логин и пароль в заголовке
        request.addValue("Basic \(loginString.base64Encoded()!)", forHTTPHeaderField: "Authorization")
        
        // Делаем сам запрос
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("Error! HTTP status code: \(httpResponse.statusCode)")
                    return
                }
            }
            
            guard let data = data else {
                print("no data received")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // Достаём логин и ссылку на аватарку
                guard let login = json!["login"] as? String,
                    let avatarURL = json!["avatar_url"] as? String else {
                    print("Login or avatar_url are not found")
                    return
                }
                
                // Переходим на вью поиска при успешной авторизации
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let userVC = storyboard.instantiateViewController(withIdentifier: "userViewController") as! UserViewController
                    userVC.avatarURL = avatarURL
                    userVC.username = login
                    
                    self.navigationController?.pushViewController(userVC, animated: true)
                }
            } else {
                print("Cannot create object form JSON")
            }
        }
        
        dataTask.resume()
    }
    
}

extension String {
    
    // Функция кодирования String в base64
    func base64Encoded() -> String? {
        if let data = self.data(using: String.Encoding.utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
}

