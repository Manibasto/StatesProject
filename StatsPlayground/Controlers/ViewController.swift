//
//  ViewController.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 10/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //FIXME: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //FIXME: - Declarations
    
    var json = [String:Any]()
    let reuseIdentifier = "Cell"
    var items : [String] = []
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var BgImage = UIImage(named: "FoodBallBg")
    var passString = String()
  
      //FIXME: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
      //FIXME: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Select your favorite pro football team below to start."
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font:  UIFont(name: "Kohinoor Bangla", size: 20)!]
        self.navigationController?.navigationBar.setBackgroundImage(BgImage,for: .default)
        
        let bgImage = UIImageView()
        bgImage.image = BgImage
        bgImage.contentMode = .scaleAspectFill
        self.collectionView?.backgroundView = bgImage
       
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.itemSize = CGSize(width: screenWidth/5, height: screenWidth/15)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        collectionView!.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        items = Getresponse(vc: ViewController.self)

        collectionView.reloadData()
    }
}

//FIXME: - UICollectionViewDelegate

extension ViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getcoutry = items[indexPath.row]
        passString = getcoutry
        performSegue(withIdentifier: "pass", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "pass" {
                let destViewController = segue.destination as! ConfirmScreenController
                destViewController.GetString = passString
            }
        }
}


//FIXME: - UICollectionViewDataSource

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        cell.TextLabel.text = self.items[indexPath.item]
        cell.layer.borderColor = UIColor.cyan.cgColor
        cell.layer.borderWidth = 1.5
        cell.TextLabel.numberOfLines = 2
        cell.TextLabel.textColor = UIColor.white
        cell.TextLabel.lineBreakMode = .byTruncatingTail 
        cell.TextLabel.minimumScaleFactor = 0.5
        cell.TextLabel.adjustsFontSizeToFitWidth = true
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        
        
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        cell.layer.masksToBounds = false
        

//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        cell.layer.shadowRadius = 10.0
//        cell.layer.shadowOpacity = 0.2
//        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        
        return cell
    }
}
