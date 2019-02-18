//
//  PopOverViewController.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 13/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {
    
    let BgImage = UIImage(named: "Bgimag")
    var json = [String:Any]()
    let reuseIdentifier = "Cell"
    var items : [String] = []
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var passString = String()

    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = BgImage
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
//        let bgImage = UIImageView()
//        bgImage.image = BgImage
//        bgImage.contentMode = .scaleAspectFill
//        self.collection?.backgroundView = bgImage
        self.collection.backgroundColor = UIColor.clear
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.itemSize = CGSize(width: screenWidth/5, height: screenWidth/15)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        collection!.collectionViewLayout = layout
        
        collection.delegate = self
        collection.dataSource = self
        
        items = Getresponse(vc: ViewController.self)
        
        collection.reloadData()
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 

}

//FIXME: - UICollectionViewDelegate

extension PopOverViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getcoutry = items[indexPath.row]
        passString = getcoutry
    }
    
}


//FIXME: - UICollectionViewDataSource

extension PopOverViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        let data = self.items[indexPath.item]
        if data == UserDefaults.GetString {
            cell.TextLabel.text = self.items[indexPath.item]
            cell.layer.borderColor =  UIColor.cyan.cgColor
            cell.layer.borderWidth = 1.5
            cell.TextLabel.numberOfLines = 2
            cell.TextLabel.textColor = UIColor.white
            cell.TextLabel.lineBreakMode = .byTruncatingTail
            cell.TextLabel.minimumScaleFactor = 0.5
            cell.TextLabel.adjustsFontSizeToFitWidth = true
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            
            let labelFont = UIFont(name: "Palatino-Italic", size: 16)
            cell.TextLabel.font = labelFont
            
            cell.contentView.backgroundColor = UIColor.lightGray
            cell.contentView.layer.masksToBounds = true
            
            
            cell.layer.shadowColor = UIColor.clear.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cell.layer.shadowRadius = 0
            cell.layer.shadowOpacity = 10
            cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        }else{
            cell.TextLabel.text = self.items[indexPath.item]
            cell.layer.borderColor =  UIColor.cyan.cgColor
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
        }
        
        return cell
    }
}
