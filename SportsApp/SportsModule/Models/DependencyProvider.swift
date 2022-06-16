//
//  DependencyProvider.swift
//  SportsApp
//
//  Created by Macbook on 07/06/2022.
//

import Foundation
import UIKit

//struct DependencyProvider {
//
//    // To Avoid Creating Instancy Everytime from NetworkManager
//    static var network: NetworkManagerProtocol {
//        return NetworkManager()
//    }
//
//    // To Avoid Creating Instance Everytime From ViewModel
//    static var sportsViewModel: SportsViewModel {
//        return SportsViewModel(network: network)
//    }
//
//    // To Avoid Creating Instance Everytime From ViewModel
//    static var sportsVC: SportsVC {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! SportsVC
//        vc.viewModelInstance = sportsViewModel
//        return vc
//    }
    
    
//    // To Avoid Creating Instancy Everytime from NetworkManager
//    static var tabBar: TabBarProtocol {
//        return TabBarHandling()
//    }
//
//    // To Avoid Creating Instance Everytime From ViewModel
//    static var tabBarViewModel: TabBarViewModel {
//        return TabBarViewModel(tabBar: tabBar)
//    }
    
//    static var tabBarC: TapBarController {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! TapBarController
//        vc.sportsViewModelInstance = sportsViewModel
//        return vc
//    }
//}
