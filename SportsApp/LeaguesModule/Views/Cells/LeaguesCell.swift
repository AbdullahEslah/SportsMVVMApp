//
//  LeaguesCell.swift
//  SportsApp
//
//  Created by Macbook on 12/06/2022.
//

import UIKit
import Kingfisher

class LeaguesCell: UITableViewCell {

    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var watchButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leagueImageView.layer.borderColor = UIColor.label.cgColor
        leagueImageView.layer.borderWidth = 1
    }


    // For Apply Responsive Rounded Corners
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        leagueImageView.layer.cornerRadius = leagueImageView.frame.width / 2
        leagueImageView.clipsToBounds = true
    }
    
    func configureCell(league: Countries) {
        
        leagueNameLabel.numberOfLines = 0
        leagueNameLabel.text = league.strLeague

            DispatchQueue.main.async {
                if let url = URL(string: league.strBadge ?? "") {
                    let placeholder = UIImage(named: "placeholder")
                    let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
                    self.leagueImageView.kf.indicatorType = .activity
                    self.leagueImageView.kf.setImage(with: url,placeholder: placeholder,options: options)
                }
            }
       

    }
    
    
    
}
