//
//  SkeletonCell.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import UIKit

class SkeletonCell: UITableViewCell {

    @IBOutlet weak var shimmerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shimmerView.layer.cornerRadius = 10
        
    }
}
