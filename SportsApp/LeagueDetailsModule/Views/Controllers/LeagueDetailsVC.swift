//
//  LeagueDetails.swift
//  SportsApp
//
//  Created by Macbook on 13/06/2022.
//

import UIKit
import Reachability
import CoreData

class LeagueDetailsVC: UIViewController {
    
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    /* Variables
     
       Has instance from ViewModel to Load (logic/Func) from it */
    var viewModelInstance : LeagueDetailsViewModel?
   
    // For Loading 0,1 CollectionViewSection
    var leageDetailsData  : [Events]?
    
    // For Loading 2 Team CollectionViewSection
    var leagueTeams       : [Teams]?
    
    // Received Params From Previous Screen
    var leagueIdParam     : String?
    var leagueNameParam   : String?
    var youtubeParam      : String?
    var imageParam        : String?
   
    // Instance For Implementing Composotional Layout Logic
    var compostionalLayoutInstance: ComposotionalLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLoved()
        Helper.hudProgress()
        listEventsData()
    }
    
    fileprivate func setupCollectionView() {
        compostionalLayoutInstance = ComposotionalLayout()
        // CollectionView Cells
        collectionView.register(UINib(nibName: "EventsCell", bundle: nil), forCellWithReuseIdentifier: "EventsCell")
        
        collectionView.register(UINib(nibName: "TeamsCell", bundle: nil), forCellWithReuseIdentifier: "TeamsCell")
        
        collectionView.register(UINib(nibName: "FacingTeamsCell", bundle: nil), forCellWithReuseIdentifier: "FacingTeamsCell")
        
        // CollectionView Header
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil),forSupplementaryViewOfKind: "header",withReuseIdentifier:"HeaderView")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = compostionalLayoutInstance.createcompositionalLayout()
    }
    
    // Checking This League Has Been Loved Or Not
    fileprivate func checkLoved() {
        ArraysManager.coreDataArray = CoreDataManager.shared.fetchLeaguesData()
        // Color The Star
        let data = ArraysManager.coreDataArray.filter{$0.idLeague == self.leagueIdParam }
        
        print(data.count)
        
        if data.count >= 1  {
            
            favoriteButton.image = UIImage(named: "filled_star")
        }
    }
    
    func listEventsData() {
        
        // Using bindSportsToSportsView Closure From The View Model To Load API Data From There
        viewModelInstance = LeagueDetailsViewModel()
        
        //  Data From APIs
        self.viewModelInstance?.listLeaguesData(leagueId: leagueIdParam ?? "")
        self.viewModelInstance?.listLeaguesTeam(leagueName: leagueNameParam ?? "")
        
        // Do Some Action After Loading upcomingEvents, LatestResults 0,1 Sections
        viewModelInstance?.bindLeagueDetailsToDetailsView = { [weak self] in
            DispatchQueue.main.async {
                Helper.dismissHud()
                self?.collectionView.isHidden = false
                self?.leageDetailsData = self?.viewModelInstance?.leagueDetailsArray ?? []
                self?.collectionView.reloadData()
            }
        }
        
        // Do Some Action After Loading Teams 2'nd Section
        viewModelInstance?.bindTeamsToDetailsView = { [weak self] in
            DispatchQueue.main.async {
                Helper.dismissHud()
                self?.collectionView.isHidden = false
                self?.leagueTeams = self?.viewModelInstance?.teamsArray ?? []
                self?.collectionView.reloadData()
            }
        }
        
        // To Stop Animation If Failed To Load Data For Any Reason
        viewModelInstance?.bindFailedToLoadData = {[weak self] in
            Helper.dismissHud()
        }
        
        // Reloading Placeholders From CollectionViews Cells
        viewModelInstance?.bindEventsPlaceholderToDetailsView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModelInstance?.bindTeamsPlaceholderToDetailsView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
    }

    @IBAction func addToFavorite(_ sender: Any) {
  
        let finalArray = CoreDataManager.shared.fetchLeaguesData()
        let theFinalArray = finalArray.filter{$0.idLeague == self.leagueIdParam}

        if theFinalArray.count >= 1  {
            Helper.displayMessage(message: "You Can't Add Existing League To Favorites Multiple Times", messageError: true)
            favoriteButton.image = UIImage(named: "filled_star")
        }else {
            Helper.displayMessage(message: "Added League Successfully To Favorites", messageError: false)
            favoriteButton.image = UIImage(named: "filled_star")
            favoriteButton.tintColor = UIColor.red
            viewModelInstance?.saveLocalData(strLeague: leagueNameParam, strBadge: imageParam, strYoutube: youtubeParam, idLeague: leagueIdParam)
        }

    }
    
    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension LeagueDetailsVC : UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        
        case 0:
            return leageDetailsData?.count ?? 1
            
        case 1:
            return leageDetailsData?.count ?? 1
            
        case 2:
            return leagueTeams?.count      ?? 1
            
        default:
            print("Error")
            return 0
        }
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        
        case 0:
            guard let firstView = self.collectionView.dequeueReusableSupplementaryView(ofKind: Constants.sectionHeaderElementKind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
                return UICollectionReusableView()
            }
            
            firstView.headerLabel.text =  "Upcoming Events"
            return firstView
        
        case 1:
            guard let secondView = self.collectionView.dequeueReusableSupplementaryView(ofKind: Constants.sectionHeaderElementKind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
                return UICollectionReusableView()
            }
            
            secondView.headerLabel.text =  "Latest Results"
            secondView.headerLabel.textAlignment = .left
            return secondView
            
        case 2:
            
            guard let thirdView = self.collectionView.dequeueReusableSupplementaryView(ofKind: Constants.sectionHeaderElementKind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
                return UICollectionReusableView()
            }
            
            thirdView.headerLabel.text =  "Teams"
            thirdView.headerLabel.textAlignment = .left
            return thirdView

            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        switch indexPath.section {
        
        case 0:
                
            guard let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCell", for: indexPath) as? EventsCell else {
                return UICollectionViewCell()
            }

            firstCell.configureCell(leagueDetails: self.leageDetailsData?[indexPath.row])
            return firstCell
            
            
        case 1:
            
            guard let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacingTeamsCell", for: indexPath) as? FacingTeamsCell else {
                return UICollectionViewCell()
            }
            
            secondCell.configureCell(teamData: self.leageDetailsData?[indexPath.row])
            return secondCell
            
        case 2:
            
            guard let thirdCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as? TeamsCell else {
                return UICollectionViewCell()
            }
            
            thirdCell.configureCell(leagueDetails: leagueTeams?[indexPath.row])
            return thirdCell
            
        default:
            
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
        let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
        guard let vc         = storyboard.instantiateViewController(withIdentifier:"TeamDetailsVC") as? TeamDetailsVC else {return}
        
        vc.name  = self.leagueTeams?[indexPath.row].strTeam
        vc.image = self.leagueTeams?[indexPath.row].strTeamBadge
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
        default:
            print("error")
        }
    }
}
