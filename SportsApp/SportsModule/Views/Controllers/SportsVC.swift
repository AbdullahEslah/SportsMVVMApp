//
//  ViewController.swift
//  SportsApp
//
//  Created by Macbook on 06/06/2022.
//

import UIKit
import SwiftMessages
import Reachability

class SportsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sportsArray       = [SportResults]()
    var reachbility       : Reachability?
    
    // Has instance from ViewModel to get logic/Func from it
    var viewModelInstance : SportsViewModel?
    let vc = NoConnectionVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "SportsCell", bundle: nil), forCellWithReuseIdentifier: "SportsCell")
        collectionView.delegate   = self
        collectionView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reachbility = try! Reachability()
        listSportsData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ConnectionManager.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachbility)
        
    }
    
    func listSportsData() {
     
        // Using bindSportsToSportsView Closure From The View Model To Load API Data From There
        viewModelInstance = SportsViewModel()
        viewModelInstance?.bindSportsToSportsView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.isHidden = false
                self?.sportsArray = self?.viewModelInstance?.sportsArray ?? []
                self?.collectionView.reloadData()
            }
        }
        
        self.viewModelInstance?.listSportsData()
        
        // Using bindConnectionToSportsView Closure From The ViewModel To Check Connection From There
        viewModelInstance?.bindConnectionToSportsView = { [weak self] in
            DispatchQueue.main.async {
                self?.present(self!.vc, animated: true, completion: nil)
                self?.vc.modalPresentationStyle = .fullScreen
                self?.vc.modalTransitionStyle   = .crossDissolve
            }
        }
        self.viewModelInstance?.foundInternetConnection()
    }
}

extension SportsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as? SportsCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(sport: self.sportsArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width / 2, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "LeaguesStoryboard", bundle: nil)
        if let leaguesVC = storyboard.instantiateViewController(withIdentifier: "LeaguesVC") as? LeaguesVC {
            leaguesVC.sportNameParam = sportsArray[indexPath.item].strSport
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        }
        
    }
 
}

    


