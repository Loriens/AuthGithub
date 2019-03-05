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
    private(set) var owner: Owner
    
    struct Owner {
        private(set) var author: String
        
        init? (json: Dictionary<String, Any>) {
            guard let login = json["login"] as? String else {
                return nil
            }
            
            author = login
        }
    }
    
    init? (json: [String: Any]) {
        guard let title = json["name"] as? String,
            let description = json["description"] as? String,
            let owner = json["owner"] as? Dictionary<String, Any> else {
            return nil
        }
        
        self.title = title
        self.description = description
        self.owner = Owner(json: owner)!
        self.author = self.owner.author
    }
    
    
}
