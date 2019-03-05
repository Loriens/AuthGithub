//
//  ReposTableViewCell.swift
//  AuthGithub
//
//  Created by Vladislav on 05/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit
import Kingfisher

class ReposTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var descr: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func congigure(with repo: Repository) {
        self.title.text = repo.title
        self.author.adjustsFontSizeToFitWidth = true
        self.author.text = repo.author
        self.descr.text = repo.description
        self.descr.sizeToFit()
        
        let avatarURL = URL(string: repo.avatarURL)
        self.avatar.kf.setImage(with: avatarURL)
    }
    
}
