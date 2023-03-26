//
//  RepositoryCell.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.setRounded()
    }

    func configureWith(repo: Repository) {
        nameLbl.text = repo.name
        stars.text = "stars = \(repo.stargazersCount)"
        descriptionLbl.text = repo.description
    }
}

extension UIView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}
