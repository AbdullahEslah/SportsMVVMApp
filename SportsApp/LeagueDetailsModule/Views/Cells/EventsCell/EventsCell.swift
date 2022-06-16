//
//  EventsCell.swift
//  SportsApp
//
//  Created by Macbook on 13/06/2022.
//

import UIKit

class EventsCell: UICollectionViewCell {
    
    @IBOutlet weak var sstackView: UIStackView!
    @IBOutlet weak var eventView: RoundedShadowView!
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var noConnectionLabel: UILabel!
    @IBOutlet weak var noConnectionImageView: UIImageView!
    
    var viewModelInstance : LeagueDetailsViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func configureCell(leagueDetails: Events?) {
       
        if leagueDetails?.strEvent == nil  && leagueDetails?.dateEvent == nil && leagueDetails?.strTime == nil{
            
            print("is nil")
            self.eventName.isHidden = true
            self.eventDate.isHidden = true
            self.eventTime.isHidden = true
            self.sstackView.isHidden = true
            
            self.noConnectionLabel.isHidden = false
            self.noConnectionImageView.isHidden = false
            
            self.noConnectionLabel.text = "No Data Available For That League !"
            
            self.noConnectionImageView.image = UIImage(named: "noData")
            
            
        } else {
            
            self.eventName.isHidden = false
            self.eventDate.isHidden = false
            self.eventTime.isHidden = false
            self.sstackView.isHidden = false
            
            self.noConnectionLabel.isHidden = true
            self.noConnectionImageView.isHidden = true
            self.eventName.numberOfLines = 0
            self.eventDate.numberOfLines = 0
            self.eventTime.numberOfLines = 0
            
            self.eventName.text = leagueDetails?.strEvent
            self.eventDate.text = leagueDetails?.dateEvent
            self.eventTime.text = leagueDetails?.strTime
        }
    }
}
