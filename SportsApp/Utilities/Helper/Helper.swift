//
//  Helper.swift
//  SportsApp
//
//  Created by Macbook on 06/06/2022.
//

import Foundation
import UIKit
import SwiftMessages

class Helper {
    
    static func displayMessage(message: String, messageError: Bool) {
        DispatchQueue.main.async {
            
           let view = MessageView.viewFromNib(layout: MessageView.Layout.messageView)
           if messageError == true {
               view.configureTheme(.error)
           } else {
               view.configureTheme(.success)
           }
           
           view.iconImageView?.isHidden = true
           view.iconLabel?.isHidden = true
           view.titleLabel?.isHidden = true
           view.bodyLabel?.text = message
           view.titleLabel?.textColor = UIColor.white
           view.bodyLabel?.textColor = UIColor.white
           view.button?.isHidden = true
           
           var config = SwiftMessages.Config()
           config.presentationStyle = .bottom
           SwiftMessages.show(config: config, view: view)
       }
    }
    
}

