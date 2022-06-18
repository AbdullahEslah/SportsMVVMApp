//
//  LeagueViewModel.swift
//  SportsApp
//
//  Created by Macbook on 12/06/2022.
//

import Foundation
import UIKit

class LeagueViewModel {
    
    // To Connect View With ViewModel Using Closures For Network Call
    var bindLeaguesToLeaguesView    : (() -> ()) = {}
    
    // To Connect View With ViewModel Using Closures For Connection
    var bindConnectionToLeaguesView : (() -> ()) = {}
    
    // To Stop Animation If Failed To Load Data For Any Reason
    var bindFailedToLoadData        : ( () -> () ) = {}
    
    let conncetion = ConnectionManager.sharedInstance
    
    //Any Changes/action Happends In sportsArray call The Closure
    var leaguesArray : [Countries]!
    {
        didSet{
            // Call The Closure Once SportResults changed instead of putting it down inside the func to observe the change here
            bindLeaguesToLeaguesView()
        }
    }
    
    func listLeaguesData(sportName:String) {
        
            NetworkManager.shared.getAllLeagues(sportName: sportName) { (countriesLeagues, error) in
                if error == nil {
                    
                    self.leaguesArray = countriesLeagues
                    
                  // print(countriesLeagues)
                } else {
                    guard let err = error else {return}
                    print(err)
                    self.bindFailedToLoadData()
                }
            }
    }
    
    func foundInternetConnection() {
        conncetion.reachability.whenReachable = {  reachability in
            Helper.displayMessage(message: "Connected", messageError: false)
        }
    }
    
        func foundNoInternetConnection() {
            conncetion.reachability.whenUnreachable = { reachability in
                Helper.displayMessage(message: "No Internet Connection", messageError: true)
                self.bindConnectionToLeaguesView()
                
            }
            
    }
    
}
