//
//  SportsCell.swift
//  SportsApp
//
//  Created by Macbook on 06/06/2022.
//

import UIKit
import Kingfisher

class SportsCell: UICollectionViewCell {

    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(sport: SportResults) {
        sportNameLabel.numberOfLines = 0
        sportNameLabel.text = sport.strSport
        
            DispatchQueue.main.async {
                if let url = URL(string: sport.strSportThumb) {
                    let placeholder = UIImage(named: "placeholder")
                    let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
                    self.sportImageView.kf.indicatorType = .activity
                    self.sportImageView.kf.setImage(with: url,placeholder: placeholder,options: options)
                }
            }

    }

}
