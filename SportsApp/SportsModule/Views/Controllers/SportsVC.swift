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
    
    // Arr For Getting Data
    var sportsArray        = [SportResults]()
    
    //Arr For Searching On Data
    var filteredSportsArr  = [SportResults]()
    
    // For Search
    let searchBar          = UISearchBar()
    
    // For Internet Handling
    var reachbility        : Reachability?
    
    // Has instance from ViewModel to Run logic/Func from it
    var viewModelInstance : SportsViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constants.splashScreen.frame = view.bounds
        // Add animationView as subview
        view.addSubview(Constants.splashScreen)
        
        // Play the animation
        Helper.showAnimation()
        
        collectionView.register(UINib(nibName: "SportsCell", bundle: nil), forCellWithReuseIdentifier: "SportsCell")
        collectionView.delegate   = self
        collectionView.dataSource = self
        configureSearchBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //collectionView.reloadData()
        listSportsData()
    }
    
    fileprivate func configureSearchBar() {
        
    let searchInstance = SearchBar()
        searchBar.delegate = self
        searchInstance.configureSearchBar(navigationItem: self.navigationItem,searchBar: searchBar)
    }
    
    func listSportsData() {

        viewModelInstance = SportsViewModel()
        self.viewModelInstance?.listSportsData()
        viewModelInstance?.bindSportsToSportsView = { [weak self] in
            DispatchQueue.main.async {
                Helper.dismissAnimation()
                self?.collectionView.isHidden = false
                self?.sportsArray = self?.viewModelInstance?.sportsArray ?? []
                self?.filteredSportsArr = (self?.sportsArray)!
                self?.collectionView.reloadData()
            }
        }
        
    }
}

extension SportsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredSportsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as? SportsCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(sport: self.filteredSportsArr[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width / 2, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "LeaguesStoryboard", bundle: nil)
        if let leaguesVC = storyboard.instantiateViewController(withIdentifier: "LeaguesVC") as? LeaguesVC {
            leaguesVC.sportNameParam = filteredSportsArr[indexPath.item].strSport
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        
        }
        
    }
}

extension SportsVC : UISearchBarDelegate,UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        guard !searchText.isEmpty else {
            self.filteredSportsArr    = self.sportsArray
            collectionView.reloadData()
            return
        }
        self.filteredSportsArr = self.sportsArray.filter({ sports -> Bool in
       
            (sports.strSport.lowercased().contains(searchText.lowercased()))
        })
        collectionView.reloadData()
    }
}
  


