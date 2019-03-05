//
//  Repository.swift
//  AuthGithub
//
//  Created by Vladislav on 05/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import Foundation

struct Repository {
    private(set) var title: String
    private(set) var description: String
    private(set) var author: String
    private(set) var avatarURL: String
    private(set) var owner: Owner
    
    struct Owner {
        private(set) var author: String
        private(set) var avatarURL: String
        
        init? (json: Dictionary<String, Any>) {
            guard let login = json["login"] as? String,
            let avatarURL = json["avatar_url"] as? String else {
                return nil
            }
            
            self.author = login
            self.avatarURL = avatarURL
        }
    }
    
    init? (json: [String: Any]) {
        guard let title = json["name"] as? String,
            let owner = json["owner"] as? Dictionary<String, Any> else {
            return nil
        }
        
        // У некоторых репозиториев нет описания, поэтому отдельная проверка на этот случай
        if let description = json["description"] as? String {
            self.description = description
        } else {
            self.description = ""
        }
        
        self.title = title
        self.owner = Owner(json: owner)!
        self.author = self.owner.author
        self.avatarURL = self.owner.avatarURL
    }
    
    
}
