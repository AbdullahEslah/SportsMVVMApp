//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by Macbook on 15/06/2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static var shared  = CoreDataManager()
    
    //Entity Name in Core Data
    var entityName     : String?
    
    // To Access viewContext from NSManagedObjectContext and saveContext() in AppDelegate
    var appDelegate    : AppDelegate?
    
    // NSManagedObjectContext => Responsible for managing objects in data base to create managed objects using instances (ex:from Movie)  by getting copies from this database
     // This Gives Us Object From DataBase To Store Our Data There
    let  viewContext   : NSManagedObjectContext?
    
    // For Detecting The Current Movie
    var currentLeague: NSManagedObject?
    
    private init() {
       
        entityName  = "SportsApp"
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        viewContext = appDelegate?.persistentContainer.viewContext
        
    }
    
    func fetchLeaguesData() -> [CoreDataModel] {
        
        ArraysManager.coreDataArray.removeAll()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataManager.shared.entityName!)
        
        do {
            let leagues = try viewContext!.fetch(fetchRequest)
           
            for league in leagues {
                
                ArraysManager.coreDataArray.append(CoreDataModel.init(strLeague: league.value(forKey: "strLeague") as? String ?? "", strBadge: league.value(forKey: "strBadge") as? String ?? "", strYoutube: league.value(forKey: "strYoutube") as? String ?? "", idLeague: league.value(forKey: "idLeague") as? String ?? ""))
            }
            
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        return ArraysManager.coreDataArray
    }
    
    func save(strLeague :String? ,strBadge:String? ,strYoutube:String? ,idLeague:String?) -> Bool {
        
        guard let viewContext = viewContext,
              let theLeagueName = strLeague,
              !theLeagueName.isEmpty,
              let theLeagueBadge = strBadge,
              !theLeagueBadge.isEmpty,
              let theLeagueYoutube = strYoutube,
              let theLeagueId = idLeague,
              !theLeagueId.isEmpty
              else {
            print("Missing Data")
            return false
        }

        // Two Steps For Getting Entity (Table) From our object => viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: CoreDataManager.shared.entityName!,
                                                      in: viewContext) else {
            return false
        }
    
        // Get The Class Required For Performing behavior required of a Core Data model object.
        let league = NSManagedObject(entity: entity,
                               insertInto: viewContext)
    
        // Set Properties Inserted Data From User To Movies Table (Entity)
        league.setValue(theLeagueName, forKey: "strLeague")
        league.setValue(theLeagueBadge, forKey: "strBadge")
        league.setValue(theLeagueYoutube, forKey: "strYoutube")
        league.setValue(theLeagueId, forKey: "idLeague")
        
        // Save Our Data (Properties) Into CoreData
        appDelegate?.saveContext()
        
        return true
    }
    
    func deleteMovie(index: Int) {
  
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName!)
        
        do {
            let leagues = try viewContext?.fetch(fetchRequest)
            
            self.currentLeague = leagues?[index]
            
            viewContext?.delete(currentLeague!)
            
            appDelegate?.saveContext()
            
            print("deleted")
            
        }  catch let error {
            print(error.localizedDescription)
        }
        
        
    }
    
}
