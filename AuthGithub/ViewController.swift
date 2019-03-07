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
        
        if let jsonData = self.readAnyAccount() {
            let decoder = JSONDecoder()
            let account = try? decoder.decode(Account.self, from: jsonData)
            
            self.loginPressed(account)
        }
    }

    @IBAction func loginPressed(_ sender: Any) {
        // Ссылка на получение информации о пользователе
        guard let baseURL = URL(string: "https://api.github.com/user") else {
            return
        }
        
        var usernameTmp: String?,
        passwordTmp: String?
        
        if let account = sender as? Account {
            usernameTmp = account.username
            passwordTmp = account.password
        } else if usernameField.text != nil && passwordField.text != nil {
            usernameTmp = usernameField.text
            passwordTmp = passwordField.text
        }
        
        guard let username = usernameTmp,
            let password = passwordTmp else {
            print("Enter login and password")
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
                
                // Сохраняем логин и пароль в Keychain
                if self.readAnyAccount() == nil {
                    if self.saveAccount(account: Account(username: username, password: password)) {
                        print("Login and password have added to Keychain")
                    }
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

// Service name for Keychain
private let service = "AuthGithub"

// Keychain functions
extension LoginViewController {
    
    private func keychainQuery() -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlocked
        query[kSecAttrService as String] = service as AnyObject
        
        return query
    }
    
    private func readAnyAccount() -> Data? {
        var query = keychainQuery()
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        
        var queryResult: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer(&queryResult))
        
        if status != noErr {
            return nil
        }
        
        guard let item = queryResult as? [String : AnyObject],
            let accountData = item[kSecValueData as String] as? Data else {
                return nil
        }
        
        return accountData
    }
    
    private func saveAccount(account: Account) -> Bool {
        let encoder = JSONEncoder()
        let accountData = try? encoder.encode(account)
        
        if readAnyAccount() != nil {
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = accountData as AnyObject
            
            let query = keychainQuery()
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            return status == noErr
        }
        
        var item = keychainQuery()
        item[kSecValueData as String] = accountData as AnyObject
        let status = SecItemAdd(item as CFDictionary, nil)
        return status == noErr
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

