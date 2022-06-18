//
//  SportsViewModel.swift
//  SportsApp
//
//  Created by Macbook on 06/06/2022.
//

import Foundation
import UIKit

class SportsViewModel {
    
    // To Connect View With ViewModel Using Closures For Network Call
    var bindSportsToSportsView    : (() -> ()) = {}
    
    // To Connect View With ViewModel Using Closures For Connection
    var bindConnectionToSportsView:(() -> ()) = {}
    
    var bindFavToFavView: ( () -> () ) = {}
    
    let conncetion       = ConnectionManager.sharedInstance
    
    var bindFavConnection: ( () -> () ) = {}
    
    //Any Changes/action Happends In sportsArray call The Closure
    var sportsArray : [SportResults]?
    {
        didSet{
            // Call The Closure Once SportResults changed instead of putting it down inside the func to observe the change here
            bindSportsToSportsView()
        }
    }
    
    func colorTheTabBarText() {
        
         //color of text under icon in tabbar controller
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: UIControl.State())

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor :UIColor.label], for: .selected)
      
    }
    
    
    func listSportsData() {
        
        NetworkManager.shared.getAllSports { [weak self] (sports, error) in
            if error == nil {
                
                self?.sportsArray = sports
                
            } else {
                guard let err = error else {return}
                print(err)
            }
        }
    }
    
    
    
    // Favorites Logic
    func noInternetConnection() {
        
        conncetion.reachability.whenUnreachable = { reachability in
            
            Helper.displayMessage(message: "You Can't Go To Details Of This View Until Reconnects To The Internet!", messageError: true)
        }
    }
    
    func foundInternetConnection() {
        conncetion.reachability.whenUnreachable = { reachability in
            
            self.bindConnectionToSportsView()
        }
        
    }
    
    func internetConnection() {
        
        conncetion.reachability.whenReachable = { reachability in
            Helper.displayMessage(message: "Has Internet ✅", messageError: false)
            self.bindFavConnection()
            
        }
    }

}
