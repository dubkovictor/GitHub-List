//
//  UIview+GithubList.swift
//  GitHub-List
//
//  Created by Victor on 27.03.2023.
//

import UIKit

extension UIView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}

extension String {
    
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
}
