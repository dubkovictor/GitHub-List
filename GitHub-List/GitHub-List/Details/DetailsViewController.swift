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
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var htmlUrlLbl: UILabel!
    
    
    var repo: Repository? // перенести в презентер
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToFavarite.addTarget(self, action: #selector(addToFavariteDidTap), for: .touchUpInside)
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(htmlUrlDidTap))
        htmlUrlLbl.isUserInteractionEnabled = true
        htmlUrlLbl.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        htmlUrlLbl.text = repo?.htmlURL
        htmlUrlLbl.attributedText = htmlUrlLbl.text?.underLined
        nameLbl.text = repo?.name
        languageLbl.text = "Language: " + (repo?.language ?? "")
        numberOfForksLbl.text = "Number of forks: \(repo?.forksCount ?? 0)"
        creationDateLbl.text = "Creation date: " + (repo?.createdAt ?? "")
        
    }
    
    @objc func addToFavariteDidTap() {
        print("addToFavariteDidTap")
        
    }
    
    @objc func htmlUrlDidTap() {
        if let url = URL(string: repo?.htmlURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
}
