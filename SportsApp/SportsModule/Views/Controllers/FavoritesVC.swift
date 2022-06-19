//
//  FavoritesVC.swift
//  SportsApp
//
//  Created by Macbook on 16/06/2022.
//

import UIKit
import Kingfisher
import Network

class FavoritesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
     
    // Variables
    var viewModelInstance : SportsViewModel?
    
    // For Checking connection Befor Going To Details Of The League (Native Way)
    let monitor = NWPathMonitor()
    var reachbility : InternetConnection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "LeaguesCell", bundle: nil), forCellReuseIdentifier: "LeaguesCell")
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Helper.hudProgress()
        getFavLeagues()

    }
    
    func getFavLeagues() {
        // Get All Leagues
        ArraysManager.coreDataArray.removeAll()
        ArraysManager.coreDataArray = CoreDataManager.shared.fetchLeaguesData()
        Helper.dismissHud()
        self.tableView.reloadData()
        if ArraysManager.coreDataArray.count == 0 {
           
            self.tableView.isHidden = true
        }else {
            
            self.tableView.isHidden = false
        }
    }
    
    
    @objc func openURL(button:UIButton) {
        if ArraysManager.coreDataArray[button.tag].strYoutube == "" {
            
            Helper.displayMessage(message: "Not Available URL For That League", messageError: true)
            
        } else {
            
            let url = URL(string: "https://\(ArraysManager.coreDataArray[button.tag].strYoutube )")
            
            if let youtubeURL = url {
                if (UIApplication.shared.canOpenURL(youtubeURL)) {
                    UIApplication.shared.open(youtubeURL)
                }
            }
        }
    }
    
}

extension FavoritesVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArraysManager.coreDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesCell",for: indexPath) as? LeaguesCell else {return UITableViewCell()}
        
        cell.leagueNameLabel.text = ArraysManager.coreDataArray[indexPath.row].strLeague
        
        DispatchQueue.main.async {
            if let url = URL(string: ArraysManager.coreDataArray[indexPath.row].strBadge) {
                let placeholder = UIImage(named: "placeholder")
                let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
                cell.leagueImageView.kf.indicatorType = .activity
                cell.leagueImageView.kf.setImage(with: url,placeholder: placeholder,options: options)
            }
        }
        
        cell.watchButton.tag = indexPath.row
        cell.watchButton.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                
                DispatchQueue.main.async {
                    
                    Helper.displayMessage(message: "Found Internet Connection ✅", messageError: false)
                    let storyboard            = UIStoryboard(name: "LeagueDetails", bundle: nil)
                    
                    guard let leagueDetailsVc = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsVC") as? LeagueDetailsVC else { return }
                    
                    leagueDetailsVc.leagueIdParam  = ArraysManager.coreDataArray[indexPath.row].idLeague
                    leagueDetailsVc.leagueNameParam = ArraysManager.coreDataArray[indexPath.row].strLeague
                    
                    leagueDetailsVc.modalPresentationStyle = .fullScreen
                    
                    self.present(leagueDetailsVc, animated: true)
                }
            } else {
                
                DispatchQueue.main.async {
                    Helper.displayMessage(message: "No Internet Connection Cant Go TO Details Of This League ", messageError: true)
                }
            }
        }
        
        //Start Implementation of Checking The Internet Connection
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete League from database table
            CoreDataManager.shared.deleteMovie(index: indexPath.row)
            ArraysManager.coreDataArray.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
    }
    
}


