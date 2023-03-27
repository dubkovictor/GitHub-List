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
    
    var isSaved = false
    
    let presenter = DetailsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(self)
        
        self.title = "Details"
        
        if isSaved {
            addToFavarite.isHidden = true
        } else {
            addToFavarite.addTarget(self, action: #selector(addToFavariteDidTap), for: .touchUpInside)
        }
        
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(htmlUrlDidTap))
        htmlUrlLbl.isUserInteractionEnabled = true
        htmlUrlLbl.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        htmlUrlLbl.text = presenter.repository?.htmlURL
        htmlUrlLbl.attributedText = htmlUrlLbl.text?.underLined
        nameLbl.text = presenter.repository?.name
        languageLbl.text = "Language: " + (presenter.repository?.language ?? "")
        numberOfForksLbl.text = "Number of forks: \(presenter.repository?.forksCount ?? 0)"
        creationDateLbl.text = "Creation date: " + (presenter.repository?.createdAt ?? "")
    }
    
    @objc func addToFavariteDidTap() {
        presenter.addToFavorite()
        
    }
    
    @objc func htmlUrlDidTap() {
        presenter.openSafary()
    }
}

extension DetailsViewController: DetailsViewDelegate {
    func openSafary(repository: Repository) {
        if let url = URL(string: repository.htmlURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
}
