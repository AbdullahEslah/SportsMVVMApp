//
//  TeamsCell.swift
//  SportsApp
//
//  Created by Macbook on 13/06/2022.
//

import UIKit
import Kingfisher

class TeamsCell: UICollectionViewCell {
    
    @IBOutlet weak var teamsView: RoundedShadowView!
    
    @IBOutlet weak var teamImageView: UIImageView!
   
    @IBOutlet weak var connectionLabel: UILabel!
    
    @IBOutlet weak var connectionImageView: UIImageView!
    
    var viewModelInstance: LeagueDetailsViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // For Apply Responsive Rounded Corners
    override func layoutSubviews() {
        super.layoutSubviews()
        teamImageView.layer.cornerRadius = teamImageView.frame.width / 2
        
    }
    
    func configureCell(leagueDetails: Teams?) {
        if leagueDetails?.strTeamBadge == nil {
            self.teamImageView.isHidden = true
            self.connectionLabel.isHidden = false
            self.connectionImageView.isHidden = false
            
            self.connectionLabel.text = "No Teams Available For That League !"
            self.connectionImageView.image = UIImage(named: "noData")
            
        } else {
            self.teamImageView.isHidden = false
            self.connectionLabel.isHidden = true
            self.connectionImageView.isHidden = true
            DispatchQueue.main.async {
                if let url = URL(string: leagueDetails?.strTeamBadge ?? "") {
                    //let placeholder = UIImage(named: "placeholder")
                    let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
                    self.teamImageView.kf.indicatorType = .activity
                    self.teamImageView.kf.setImage(with: url,placeholder: nil,options: options)
                }
            }
        }
    }
}
