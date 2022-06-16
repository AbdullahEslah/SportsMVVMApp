//
//  LeaguesVC.swift
//  SportsApp
//
//  Created by Macbook on 12/06/2022.
//

import UIKit
import Reachability

class LeaguesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var leaguesArray      = [Countries]()
    var reachbility       : Reachability?
    
    // Has instance from ViewModel to get logic/Func from it
    var viewModelInstance : LeagueViewModel?
    let vc = NoConnectionVC()
    var sportNameParam = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "LeaguesCell", bundle: nil), forCellReuseIdentifier: "LeaguesCell")
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listLeaguesData()
        reachbility = try! Reachability()
      
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ConnectionManager.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachbility)
        
    }
    
    
    
    func listLeaguesData() {
    
        // Using bindSportsToSportsView Closure From The View Model To Load API Data From There
        viewModelInstance = LeagueViewModel()
        
        viewModelInstance?.bindLeaguesToLeaguesView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.isHidden = false
                self?.leaguesArray = self?.viewModelInstance?.leaguesArray ?? []

                self?.tableView.reloadData()
            }
        }
        
        self.viewModelInstance?.listLeaguesData(sportName: sportNameParam)
        
        viewModelInstance?.bindConnectionToLeaguesView = { [weak self] in
            DispatchQueue.main.async {
                self?.present(self!.vc, animated: true, completion: nil)
                self?.vc.modalPresentationStyle = .fullScreen
                self?.vc.modalTransitionStyle   = .crossDissolve
            }
        }
        self.viewModelInstance?.foundInternetConnection()
    }
    
    @objc func setActionButton(button:UIButton) {
     
        if self.leaguesArray[button.tag].strYoutube == "" {
            
            Helper.displayMessage(message: "Not Available URL For That League", messageError: true)
            
        } else {
            
            let url = URL(string: "https://\(self.leaguesArray[button.tag].strYoutube ?? "")")
            
            if let youtubeURL = url {
                if (UIApplication.shared.canOpenURL(youtubeURL)) {
                    UIApplication.shared.open(youtubeURL)
                }
            }
        }
    }

}
extension LeaguesVC :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesCell", for: indexPath) as? LeaguesCell else {
            return UITableViewCell()
        }
        cell.configureCell(league: self.leaguesArray[indexPath.item])
        cell.watchButton.tag = indexPath.row
        cell.watchButton.addTarget(self, action: #selector(setActionButton(button:)), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
        
        guard let vc          = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsVC") as? LeagueDetailsVC else {return}
        
        vc.leagueIdParam   = leaguesArray[indexPath.row].idLeague   ?? ""
        vc.leagueNameParam = leaguesArray[indexPath.row].strLeague  ?? ""
        vc.youtubeParam    = leaguesArray[indexPath.row].strYoutube ?? ""
        vc.imageParam      = leaguesArray[indexPath.row].strBadge   ?? ""
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
}


