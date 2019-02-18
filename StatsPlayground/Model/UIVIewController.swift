//
//  UIVIewController.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 10/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }   
    
    // var items : [String] = []
    func Getresponse(vc : AnyClass)-> [String] {
        var items:[String] = []
        var JSon = [String:Any]()
        do {
            if let file = Bundle(for: vc).url(forResource: "countries", withExtension: "json") {
                let data = try Data(contentsOf: file)
                JSon = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                let GetValue = RootClass(fromDictionary: JSon)
                let b = GetValue.countries
                for i in b! {
                    items.append(i.name)
                }
            }
            else {
                print("can't find a bundle for the countries")
            }
        } catch {
            print(error.localizedDescription)
        }
        return items
    }
}
enum Storyboard {
    case main
}

extension Storyboard {
    var name:String {
        switch self {
        case .main: return "Main"
        }
    }
    
    func instantiate<T:UIViewController>(viewController indentifier:String) -> T {
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: indentifier) as! T
    }
}

extension UserDefaults{
    class var GetString : String {
        get { return standard.string(forKey: "GetString") ?? "" }
        set {
            standard.set(newValue, forKey: "GetString")
            standard.synchronize()
        }
    }
}

protocol ViewControllerActivity: class {
    var loadingView:UIVisualEffectView? { get set }
}

extension ViewControllerActivity where Self:UIViewController {
    func presentLoadingView(labelText: String) {
        guard loadingView == nil else { return }
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        loadingView = UIVisualEffectView(effect: blurEffect)
        loadingView?.frame = view.bounds
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.center = loadingView?.center ?? view.center
        spinner.startAnimating()
        loadingView?.contentView.addSubview(spinner)
        loadingView.flatMap(view.addSubview)
        loadingView?.alpha = 0
        // for loading screen background only
        let labelVerifying = UILabel(frame: CGRect(x: 0, y: 0, width: 195, height: 25))
        labelVerifying.textAlignment = .center
        labelVerifying.center = spinner.center
        labelVerifying.frame = CGRect(x: labelVerifying.frame.origin.x,
                                      y: labelVerifying.frame.origin.y + 40,
                                      width: labelVerifying.frame.width,
                                      height: labelVerifying.frame.height)
        labelVerifying.text = labelText
        labelVerifying.font = UIFont(name: "MuseoSans-500", size: 14)
        labelVerifying.textColor = UIColor.white
        loadingView?.backgroundColor = labelVerifying.text == "Loading Please Wait..." ? UIColor.clear : UIColor(white: 1, alpha: 1)
        loadingView?.contentView.addSubview(labelVerifying)
        UIView.animate(withDuration: 0.2, animations: { [unowned self] () -> Void in
            self.loadingView?.alpha = 1
        })
    }
    
    func dismissLoadingView()
    {
        DispatchQueue.main.async()  { [weak self] () -> Void in
            self?.loadingView?.removeFromSuperview()
            self?.loadingView = nil
        }
    }}

