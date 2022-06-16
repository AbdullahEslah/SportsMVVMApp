//
//  TabBarHandling.swift
//  SportsApp
//
//  Created by Macbook on 08/06/2022.
//

import Foundation
import UIKit

class TabBarHandling : TabBarProtocol {
    
    func colorTheTabBarText(completion: @escaping ()->()) {
            // color of text under icon in tabbar controller
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: UIControl.State())
    
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor :UIColor.label], for: .selected)
        completion()
        }
    
}

