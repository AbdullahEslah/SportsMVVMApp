//
//  FacingTeamsCell.swift
//  SportsApp
//
//  Created by Macbook on 13/06/2022.
//

import UIKit

class FacingTeamsCell: UICollectionViewCell {
    @IBOutlet weak var facingView: RoundedShadowView!
    
    @IBOutlet var stackViews: [UIStackView]!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var resultLabel1: UILabel!
    @IBOutlet weak var resultLabel2: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var connectionImageView: UIImageView!
    
    @IBOutlet weak var connectionLabel: UILabel!
    
    var viewModelInstance : LeagueDetailsViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(teamData: Events?) {
        
        if teamData?.dateEvent == nil {
            for stack in self.stackViews ?? [] {
                stack.isHidden = true
            }
            
            self.firstNameLabel.isHidden = true
            self.secondNameLabel.isHidden = true
            self.resultLabel1.isHidden = true
            self.resultLabel2.isHidden = true
            self.dateLabel.isHidden = true
            self.timeLabel.isHidden = true
            
            self.connectionLabel.isHidden = false
            self.connectionLabel.numberOfLines = 0
            self.connectionImageView.isHidden = false
            
            self.connectionLabel.text = "No Data Available For That League !"
            self.connectionImageView.image = UIImage(named: "noData")
            
        }else {
            for stack in self.stackViews ?? [] {
                stack.isHidden = false
            }
            self.firstNameLabel.isHidden = false
            self.secondNameLabel.isHidden = false
            self.resultLabel1.isHidden = false
            self.resultLabel2.isHidden = false
            self.dateLabel.isHidden = false
            self.timeLabel.isHidden = false
            
            self.connectionLabel.isHidden = true
            self.connectionImageView.isHidden = true
            
            firstNameLabel.numberOfLines  = 0
            secondNameLabel.numberOfLines = 0
            resultLabel1.numberOfLines    = 0
            resultLabel2.numberOfLines    = 0
            dateLabel.numberOfLines       = 0
            timeLabel.numberOfLines       = 0
            
            firstNameLabel.text  = teamData?.strHomeTeam
            secondNameLabel.text = teamData?.strAwayTeam
            resultLabel1.text    = teamData?.intHomeScore
            resultLabel2.text    = teamData?.intAwayScore
            dateLabel.text       = teamData?.dateEvent
            timeLabel.text       = teamData?.strTime
        }
    }
}
