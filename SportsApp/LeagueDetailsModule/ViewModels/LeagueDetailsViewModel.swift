//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Macbook on 13/06/2022.
//

import Foundation

class LeagueDetailsViewModel {
    
    // To Connect View With ViewModel Using Closures For Network Call
    var bindLeagueDetailsToDetailsView    : (() -> ()) = {}
    
    // To Connect View With ViewModel Using Closures For Network Call
    var bindTeamsToDetailsView            : (() -> ()) = {}
    
    // To Connect View With ViewModel Using Closures For Connection
    var bindConnectionToDetailsView       : (() -> ()) = {}
    
    // For Placeholders
    var bindEventsPlaceholderToDetailsView: (() -> ()) = {}
    var bindTeamsPlaceholderToDetailsView : (() -> ()) = {}
    
    // To Stop Animation If Failed To Load Data For Any Reason
    var bindFailedToLoadData              : ( () -> () ) = {}
    
    let conncetion = ConnectionManager.sharedInstance
    
    //Any Changes/action Happends In sportsArray call The Closure
    var leagueDetailsArray : [Events]?
    
    {
        didSet{
            // Call The Closure Once SportResults changed instead of putting it down inside the func to observe the change here
            bindLeagueDetailsToDetailsView()
        }
    }
    
    var teamsArray          : [Teams]?
    {
        didSet{
            // Call The Closure Once SportResults changed instead of putting it down inside the func to observe the change here
            bindTeamsToDetailsView()
        }
    }
    
    func listLeaguesData(leagueId:String) {
        NetworkManager.shared.getLeagueDetails(leageId: leagueId) { (events, error) in
            
                if error == nil {
                    if events?.count == nil    {
                        self.bindEventsPlaceholderToDetailsView()
                    }else {
                        self.leagueDetailsArray = events
                    }
                } else {
                    self.bindFailedToLoadData()
                }
            }
    }
    
    func listLeaguesTeam(leagueName:String) {
        NetworkManager.shared.getTeams(leagueName: leagueName) { (teams, error) in
            
            if error == nil {
                
                if teams?.count == nil {
                    self.bindTeamsPlaceholderToDetailsView()
                } else {
                    self.teamsArray = teams
                }
                } else {
                    self.bindFailedToLoadData()
                }
            }
    }
    
    func saveLocalData(strLeague :String? ,strBadge:String? ,strYoutube:String? ,idLeague:String?) {
        //ArrayManager.moviesData.removeAll()
        if CoreDataManager.shared.save(strLeague :strLeague ?? "" ,strBadge:strBadge ?? "" ,strYoutube:strYoutube ?? "" ,idLeague:idLeague ?? "") {
            print("saved")
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
                self.bindConnectionToDetailsView()
                
            }
            
    }
    
   
}
