//
//  TeamStandingConreoller.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 10/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit

class ConfirmScreenController: UIViewController {
    
    //FIXME: - IBOutlet
    @IBOutlet weak var Collectionview: UICollectionView!
    @IBOutlet weak var YesBtn: UIButton!
    @IBOutlet weak var NoBtn: UIButton!
    @IBOutlet weak var LabelText: UILabel!
    
    
    //FIXME: - Decrations
    var json = [String:Any]()
    let reuseIdentifier = "Cell"
    var items : [String] = []
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    let BgImage = UIImage(named: "Bgimag")
    let BgImage1 = UIImage(named: "FoodBallBg")    
    var GetString = String()
    
    //FIXME: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        let main_string = "Confirm that the team you selected is \(GetString) to enter the App:"
        let string_to_color = GetString
        let range = (main_string as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:main_string)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow , range: range)
        
        LabelText.text = main_string
        LabelText.attributedText = attributedString

        Collectionview.delegate = self
        Collectionview.dataSource = self
        
        items = Getresponse(vc: ViewController.self)
        
        Collectionview.reloadData()        
    }
    
    //FIXME: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor =  hexStringToUIColor(hex: "#43A047")
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = BgImage
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        YesBtn.layer.borderColor = UIColor.cyan.cgColor
        YesBtn.layer.borderWidth = 1.5
        YesBtn.layer.cornerRadius = 5
        YesBtn.layer.masksToBounds = true
        
        YesBtn.layer.shadowColor = UIColor.black.cgColor
        YesBtn.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        YesBtn.layer.shadowRadius = 10.0
        YesBtn.layer.shadowPath = UIBezierPath(roundedRect:YesBtn.bounds, cornerRadius:YesBtn.layer.cornerRadius).cgPath
        YesBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        NoBtn.layer.borderColor = UIColor.cyan.cgColor
        NoBtn.layer.borderWidth = 1.5
        NoBtn.layer.cornerRadius = 5
        NoBtn.layer.masksToBounds = true
        NoBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        NoBtn.layer.shadowColor = UIColor.black.cgColor
        NoBtn.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        NoBtn.layer.shadowRadius = 10.0
        NoBtn.layer.shadowPath = UIBezierPath(roundedRect:YesBtn.bounds, cornerRadius:YesBtn.layer.cornerRadius).cgPath
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        let bgImage = UIImageView()
        bgImage.image = BgImage
        bgImage.contentMode = .scaleAspectFill
        self.Collectionview?.backgroundView = bgImage
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.itemSize = CGSize(width: screenWidth/5, height: screenWidth/15)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        Collectionview!.collectionViewLayout = layout
        
    }
    
    //FIXME: - YesBtn
    @IBAction func YesBtn(_ sender: Any) {
        UserDefaults.GetString = GetString
        self.performSegue(withIdentifier: String(describing: StandingVC.self), sender: nil)

    }
    //FIXME: - NoBtn
    @IBAction func NoBtn(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //FIXME: - viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let i = items.index(of: GetString) {
            let indexPath = IndexPath(item: i, section: 0)
            self.Collectionview.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        }
    }
}
//FIXME: - UICollectionViewDelegate

extension ConfirmScreenController:UICollectionViewDelegate{
    
}

//FIXME: - UICollectionViewDataSource

extension ConfirmScreenController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        let data = self.items[indexPath.item]
        if data == GetString {
            cell.TextLabel.text = self.items[indexPath.item]
//            cell.layer.borderColor = UIColor.cyan.cgColor
//            cell.layer.borderWidth = 1.5
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
extension ConfirmScreenController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let helpPageController = segue.destination as? StandingVC {
            helpPageController.helpType = .passport
        }
    }
}

