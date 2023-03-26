//
//  DetailsViewController.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var numberOfForksLbl: UILabel!
    @IBOutlet weak var creationDateLbl: UILabel!
    @IBOutlet weak var addToFavarite: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToFavarite.addTarget(self, action: #selector(addToFavariteDidTap), for: .touchUpInside)
    }
    
    @objc func addToFavariteDidTap() {
        print("addToFavariteDidTap")
    }
    
}
