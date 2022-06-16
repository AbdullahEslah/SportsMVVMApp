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
    
    var bindTabBar: (() -> ()) = {}
    
    
    var bindFavToFavView: ( () -> () ) = {}
    
    let conncetion = ConnectionManager.sharedInstance
    
    var bindFavConnection: ( () -> () ) = {}
    //Any Changes/action Happends In sportsArray call The Closure
    var sportsArray : [SportResults]!
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

        self.bindTabBar()
      
    }
    
    
    func listSportsData() {
        
        NetworkManager.shared.getAllSports { [weak self] (sports, error) in
            if error == nil {
                
                self?.sportsArray = sports
                // Helper.displayMessage(message: err.localizedDescription, messageError: Fa)
            } else {
                guard let err = error else {return}
                
                Helper.displayMessage(message: err.localizedDescription, messageError: true)
            }
        }
    }
    
    
    
    func foundInternetConnection() {
        
        conncetion.reachability.whenUnreachable = { reachability in
            
            Helper.displayMessage(message: "No Internet Connection !", messageError: true)
            self.bindConnectionToSportsView()
            
            
            if reachability.connection == .wifi || reachability.connection == .cellular {
                
                Helper.displayMessage(message: "Found Internet Connection ✅", messageError: false)
            }
        }
    }
    
    func internetConnection() {
        
        conncetion.reachability.whenReachable = { reachability in
            
            self.bindFavConnection()
            
        }
    }
    
}
