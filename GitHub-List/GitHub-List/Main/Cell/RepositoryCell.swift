//
//  RepositoryCell.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import UIKit
import Kingfisher

class RepositoryCell: UITableViewCell {
    
    private var downloadTask: DownloadTask?
    
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset Thumbnail Image View
        avatarImage.image = nil
        
        // Cancel Download Task
        downloadTask?.cancel()
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.setRounded()
    }

    func configureWith(repo: Repository) {
        nameLbl.text = repo.name
        stars.text = "stars = \(repo.stargazersCount )"
        descriptionLbl.text = repo.description
        
        downloadTask = KF.url( URL(string: repo.owner.avatarURL))
            .set(to: avatarImage)
    }
}

