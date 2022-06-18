//
//  NoConnection.swift
//  SportsApp
//
//  Created by Macbook on 11/06/2022.
//

import UIKit

class NoConnectionVC: UIViewController {
    @IBOutlet weak var bgView: UIVisualEffectView!
    
    @IBOutlet weak var noConnectionImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noConnectionImage.image = UIImage(named:"NoInternet")
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissButtonClicked(_:)))
        tap.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.frame = UIScreen.main.bounds

    }
    
    @objc func dismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
