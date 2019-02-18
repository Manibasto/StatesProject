//
//  TeamStandingsController.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 10/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit
import Charts

class TeamStandingsController: UIViewController,ViewControllerActivity,ChartViewDelegate,UIPopoverPresentationControllerDelegate {
    
    var loadingView: UIVisualEffectView?
    var blurEffect = UIBlurEffect()
    var blurredEffectView = UIVisualEffectView()
    var visualEffectView   = UIVisualEffectView()
    
    @IBOutlet weak var CountryName: UILabel!
    @IBOutlet weak var team_standing: UILabel!
    @IBOutlet weak var show_winning: UILabel!
    @IBOutlet weak var showing_Divisions_Standings: UILabel!
    @IBOutlet weak var dropdown: DropDown!
    @IBOutlet weak var GetMoreTeams: UILabel!
    @IBOutlet weak var ScoreBoard: UITableView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var BubbleChartView: BubbleChartView!
    @IBOutlet weak var GetMore: UIButton!
    
    let BgImage = UIImage(named: "StandlingBg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentLoadingView(labelText: "Loading Please Wait...")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0), execute: {
            self.dismissLoadingView()
        })
        
        Update()
        setDataCount(15, range: 30)
        
        self.navigationController?.navigationBar.isHidden = true
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = BgImage
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        CountryName.text = UserDefaults.GetString
        CountryName.textColor = UIColor(red: 251/255, green: 140/255, blue: 0/255, alpha: 1.0)
        team_standing.textColor = UIColor.white
        
        
        show_winning.layer.borderColor = UIColor.cyan.cgColor
        show_winning.layer.borderWidth = 0.5
        show_winning.layer.cornerRadius = 3
        show_winning.layer.masksToBounds = true
        show_winning.textColor = UIColor.white
        show_winning.backgroundColor = UIColor.lightGray
        
        showing_Divisions_Standings.layer.borderColor = UIColor.cyan.cgColor
        showing_Divisions_Standings.layer.borderWidth = 0.5
        showing_Divisions_Standings.layer.cornerRadius = 3
        showing_Divisions_Standings.layer.masksToBounds = true
        showing_Divisions_Standings.textColor = UIColor.black
        showing_Divisions_Standings.backgroundColor = UIColor.green
        
        GetMoreTeams.layer.borderColor = UIColor.cyan.cgColor
        GetMoreTeams.layer.borderWidth = 1.6
        GetMoreTeams.layer.cornerRadius = 10
        GetMoreTeams.layer.masksToBounds = true
        GetMoreTeams.textColor = UIColor.white
        GetMoreTeams.backgroundColor = UIColor(red: 0/255, green: 172/255, blue: 193/255, alpha: 1.0)
        
        GetMoreTeams.layer.shadowColor = UIColor.yellow.cgColor
        GetMoreTeams.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        GetMoreTeams.layer.shadowOpacity = 10
        GetMoreTeams.layer.shadowRadius = 10.0
        GetMoreTeams.layer.shadowPath = UIBezierPath(roundedRect:GetMoreTeams.bounds,cornerRadius:GetMoreTeams.layer.cornerRadius).cgPath
        
        
        dropdown.optionArray = ["Team1", "Team 2", "Team 3"]
        dropdown.optionIds = [1,23,54,22]
        dropdown.arrow.tintColor = UIColor.white
        
        dropdown.didSelect{(selectedText , index ,id) in
            self.dropdown.text = "\(selectedText)"
        }
        
        self.scrollview.bringSubviewToFront(ScoreBoard)
        self.scrollview.bringSubviewToFront(dropdown)
        self.scrollview.bringSubviewToFront(BubbleChartView)
        
        ScoreBoard.layer.borderWidth = 1.0
        ScoreBoard.layer.borderColor = UIColor.white.cgColor
        
        GetMore.backgroundColor = UIColor.lightGray
        GetMore.setTitleColor(UIColor.white, for: .normal)
        
        GetMore.layer.shadowColor = UIColor.black.cgColor
        GetMore.layer.shadowRadius = 3.0
        GetMore.layer.shadowOpacity = 1.0
        GetMore.layer.shadowOffset = CGSize(width: 4, height: 4)
        GetMore.layer.masksToBounds = false
        
        self.GetMore.superview?.bringSubviewToFront(GetMore)
        self.ScoreBoard.delegate = self
        self.ScoreBoard.dataSource = self
        self.ScoreBoard.separatorStyle = .singleLine
        self.ScoreBoard.separatorColor = UIColor.white
        self.ScoreBoard.backgroundColor = UIColor.clear
    }
   
    func Update(){
        
        BubbleChartView.delegate = self
        
        BubbleChartView.chartDescription?.enabled = false
        
        BubbleChartView.dragEnabled = false
        BubbleChartView.setScaleEnabled(true)
        BubbleChartView.maxVisibleCount = 200
        BubbleChartView.pinchZoomEnabled = true
        
        BubbleChartView.legend.horizontalAlignment = .right
        BubbleChartView.legend.verticalAlignment = .top
        BubbleChartView.legend.orientation = .vertical
        BubbleChartView.legend.drawInside = false
        BubbleChartView.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        BubbleChartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        BubbleChartView.leftAxis.spaceTop = 0.3
        BubbleChartView.leftAxis.spaceBottom = 0.3
        BubbleChartView.leftAxis.axisMinimum = 0
        
        BubbleChartView.rightAxis.enabled = false
        
        BubbleChartView.xAxis.labelPosition = .bottom
        BubbleChartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
    }
    
    func BlurEffect(){
        blurEffect = UIBlurEffect(style: .dark)
        blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = scrollview.bounds
        view.addSubview(blurredEffectView)
    }
    
    func CallPopOver() {
        self.BlurEffect()
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "PopOverViewController") as? PopOverViewController
        popupVC?.preferredContentSize = CGSize(width: scrollview.frame.width, height: scrollview.frame.height)
        popupVC?.modalPresentationStyle = UIModalPresentationStyle.popover
        popupVC?.popoverPresentationController?.delegate = self ;
        popupVC?.popoverPresentationController?.sourceView = self.view
        popupVC?.popoverPresentationController?.sourceRect = CGRect(x:self.view.bounds.midX, y: self.view.bounds.midY,width: 0,height: 0)
        popupVC?.popoverPresentationController?.backgroundColor = UIColor.clear
        popupVC?.view.layer.borderColor = UIColor.clear.cgColor
        popupVC?.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        self.present(popupVC!, animated: true, completion: nil)
    }

    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        blurredEffectView.isHidden = true
        visualEffectView.isHidden = true
    }
    
    @IBAction func GetMoreBtn(_ sender: Any) {
        CallPopOver()
    }
    
    
   
    
}

extension TeamStandingsController: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
            return cell!
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
            return cell!
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3")
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as! TableViewCell4
            
            let string_to_color = "LOSS"
            let main_string = "WIN / \(string_to_color)"
            let range = (main_string as NSString).range(of: string_to_color)
            let range1 = (string_to_color as NSString).range(of: string_to_color)
            let attributedString = NSMutableAttributedString(string:main_string)
            let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 18.0)!]
            attributedString.addAttributes(myAttribute, range: range1)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow , range: range)
            cell.winoff.text = main_string
            cell.winoff.attributedText = attributedString
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 20
        }
        else if indexPath.row == 1 {
            return 20
        }
        else if indexPath.row == 2 {
            return 20
        }
        else {
            return tableView.frame.size.height - 20 - 20 - 20
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func setDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(range))
            let size = CGFloat(arc4random_uniform(range))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size, icon: UIImage(named: "icon"))
        }
        let yVals2 = (0..<count).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(range))
            let size = CGFloat(arc4random_uniform(range))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size, icon: UIImage(named: "icon"))
        }
        let yVals3 = (0..<count).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(range))
            let size = CGFloat(arc4random_uniform(range))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size)
        }
        
        let set1 = BubbleChartDataSet(values: yVals1, label: "Team 1")
        set1.drawIconsEnabled = false
        set1.setColor(ChartColorTemplates.colorful()[0], alpha: 0.5)
        set1.drawValuesEnabled = true
        
        let set2 = BubbleChartDataSet(values: yVals2, label: "Team 2")
        set2.drawIconsEnabled = false
        set2.iconsOffset = CGPoint(x: 0, y: 15)
        set2.setColor(ChartColorTemplates.colorful()[1], alpha: 0.5)
        set2.drawValuesEnabled = true
        
        let set3 = BubbleChartDataSet(values: yVals3, label: "Team 3")
        set3.setColor(ChartColorTemplates.colorful()[2], alpha: 0.5)
        set3.drawValuesEnabled = true
        
        let data = BubbleChartData(dataSets: [set1, set2, set3])
        data.setDrawValues(false)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 7)!)
        data.setHighlightCircleWidth(1.5)
        data.setValueTextColor(.white)
        
        BubbleChartView.data = data
    }
    
}


