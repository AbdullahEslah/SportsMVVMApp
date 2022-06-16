//
//  NoConnection.swift
//  SportsApp
//
//  Created by Macbook on 11/06/2022.
//

import UIKit

class NoConnectionVC: UIViewController {

    @IBOutlet weak var noConnectionImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = CustomColors.noInternetColor
        
        noConnectionImage.image = UIImage(named:"NoInternet")
    }

}
