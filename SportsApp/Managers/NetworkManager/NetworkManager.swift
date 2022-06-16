//
//  NetworkManager.swift
//  SportsApp
//
//  Created by Macbook on 06/06/2022.
//

import UIKit
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()

     init() {
        
    }
     
    enum EndPoints {
        
        static let base = "https://www.thesportsdb.com"
        
        
    
        case sportsList
        
        case leaguesList
        
        case leageDetails
        
        case leageTeams
        
       
        
        var stringValue: String {
            
            switch self {
            
            case .sportsList:
                return EndPoints.base + "/api/v1/json/2/all_sports.php"
                
            case .leaguesList:
                return EndPoints.base + "/api/v1/json/2/search_all_leagues.php?s="
                
            case .leageDetails:
                return EndPoints.base + "/api/v1/json/2/eventsseason.php?"
                
            case .leageTeams:
                return EndPoints.base + "/api/v1/json/2/search_all_teams.php?"
          
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    //Generic Get Request We Usually don't pass parameters like post we put it in the url
     func taskForGETRequest<ResponseType:Decodable>(url:URL, responseType: ResponseType.Type,completion: @escaping (ResponseType?, Error?) -> Void ){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(nil,error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil,error)
                return
            }
            
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
        
    }

    func getAllSports(completion: @escaping ([SportResults], Error?) -> Void) {
        
        let endPoints = EndPoints.sportsList.url
        
        //responseType -> the main model
        taskForGETRequest(url:endPoints , responseType: SportsData.self) { (response, error) in
            if let response = response  {
                //result -> is the [meals]
                completion(response.sports,nil)
            } else {
                completion([],error)
            }
        }
    }
    
    // Get All Leagues By Param s => sportName
    func getAllLeagues(sportName:String,completion: @escaping ([Countries], Error?) -> Void) {
 
        var mainURL  = URLComponents(string: EndPoints.base)
        mainURL?.path = "/api/v1/json/2/search_all_leagues.php"
        mainURL?.query = "s=\(sportName)"
        let url = (mainURL?.url)!
    
        //responseType -> the main model
        taskForGETRequest(url:url , responseType: CountriesData.self) { (response, error) in
            if let response = response  {
                completion(response.countries,nil)
            } else {
                completion([],error)
            }
        }
    }
    
    
    func getLeagueDetails(leageId:String,completion: @escaping ([Events]?,Error?)->Void) {
        
        let endPoints = EndPoints.leageDetails.stringValue + "id=\(leageId)"
     
        guard let url = URL(string: endPoints) else {
            return
        }
      
        //responseType -> the main model
        taskForGETRequest(url:url , responseType: EventsData.self) { (response, error) in
            if let response = response  {
                completion(response.events,nil)
            } else {
                completion([],error)
            }
        }
    }
    
    
    func getTeams(leagueName:String,completion: @escaping([Teams]?,Error?)->Void) {
        
        var mainURL  = URLComponents(string: EndPoints.base)
        mainURL?.path = "/api/v1/json/2/search_all_teams.php"
        mainURL?.query = "l=\(leagueName)"
        let url = (mainURL?.url)!
      
        //responseType -> the main model
        taskForGETRequest(url:url , responseType: TeamsData.self) { (response, error) in
            
            if let response = response  {
                completion(response.teams,nil)
            } else {
                completion([],error)
            }
        }
    }
    
}
