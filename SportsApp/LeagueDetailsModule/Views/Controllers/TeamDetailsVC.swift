//
//  TeamDetailsVC.swift
//  SportsApp
//
//  Created by Macbook on 16/06/2022.
//

import UIKit
import Kingfisher

class TeamDetailsVC: UIViewController {
    
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    
    // Variable
    var image: String?
    var name : String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Helper.hudProgress()
        gotDataFromLastSscreen()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        teamImageView.layer.cornerRadius = teamImageView.frame.width / 2
        teamImageView.clipsToBounds = true
        teamImageView.layer.borderColor = UIColor.label.cgColor
        teamImageView.layer.borderWidth = 1
    }
    
    fileprivate func gotDataFromLastSscreen() {
        Helper.dismissHud()
        teamNameLabel.text  = name
        DispatchQueue.main.async {
            if let url = URL(string: self.image ?? "") {
                let placeholder = UIImage(named: "placeholder")
                let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
                self.teamImageView.kf.indicatorType = .activity
                self.teamImageView.kf.setImage(with: url,placeholder: placeholder,options: options)
            }
        }
    }
    
    @IBAction func dimissButtonClicked(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
}
