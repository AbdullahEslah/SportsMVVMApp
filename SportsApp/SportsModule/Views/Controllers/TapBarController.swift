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
//        for navController in viewControllers! {
//            if let navController = navController as? UINavigationController,
//               let viewController = navController.viewControllers.first
//                    as? NetworkManagerProtocol {
//                        viewController.inject(data: moviesManager)
//            }
//        }
        
//        sportsViewModelInstance = SportsViewModel()
        // Do any additional setup after loading the view.
//        sportsViewModelInstance?.colorTheTabBarText()
        sportsViewModelInstance?.bindTabBar = { [weak self]  in
//            gurad let self = self else {return}
//            DispatchQueue.main.async {
//                UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: UIControl.State())
//
//                UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor :UIColor.label], for: .selected)
//                self?.collectionView.isHidden = false
//                imageView.isHidden = true
//                self?.sportsArray = self?.viewModelInstance?.sportsArray ?? []
//                self?.collectionView.reloadData()
            
            }
        
        
        self.sportsViewModelInstance?.colorTheTabBarText()
        
        
//        sportsViewModelInstance.
    }
   
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
////        let vc = SportsVC()
////        present(vc, animated: true, completion: nil)
//    }

}
