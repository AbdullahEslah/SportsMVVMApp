//
//  TapBarController.swift
//  SportsApp
//
//  Created by Macbook on 06/06/2022.
//

import UIKit

class TapBarController: UITabBarController {
    
    var sportsViewModelInstance: SportsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        sportsViewModelInstance = SportsViewModel()
        self.sportsViewModelInstance?.colorTheTabBarText()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
}
