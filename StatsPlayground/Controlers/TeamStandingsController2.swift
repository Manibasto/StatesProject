//
//  TeamStandingsController2.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 11/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit

class TeamStandingsController2: UIViewController {
    let BgImage = UIImage(named: "StandlingBg")

    @IBOutlet weak var BackBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackBtn.backgroundColor = UIColor.yellow
        BackBtn.setTitleColor(UIColor.black, for: .normal)
        BackBtn.layer.borderWidth = 0.5
        BackBtn.layer.backgroundColor = UIColor.white.cgColor
        BackBtn.layer.shadowColor = UIColor.black.cgColor
        BackBtn.layer.shadowRadius = 3.0
        BackBtn.layer.shadowOpacity = 1.0
        BackBtn.layer.shadowOffset = CGSize(width: 4, height: 4)
        BackBtn.layer.masksToBounds = false
        BackBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationController?.navigationBar.isHidden = true
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = BgImage
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
   }
    @objc func buttonAction(sender: UIButton!){
        navigationController?.popToRootViewController(animated: true)
    }
  
}
