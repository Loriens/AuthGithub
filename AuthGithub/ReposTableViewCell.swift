//
//  ReposTableViewCell.swift
//  AuthGithub
//
//  Created by Vladislav on 05/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class ReposTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var descr: UILabel!
    var repository: Repository?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
