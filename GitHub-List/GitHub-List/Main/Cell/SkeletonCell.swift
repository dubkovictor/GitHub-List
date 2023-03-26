//
//  SkeletonCell.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import UIKit

class SkeletonCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.backgroundColor = .yellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
