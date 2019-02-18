//
//  StandingVC.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 11/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit

class StandingVC: UIPageViewController {
    var pageControl = UIPageControl()

    enum HelpType {
        case passport
        var viewControllers:[UIViewController] {
            switch self {
            case .passport:
                let passportTip1 = Storyboard.main.instantiate(viewController: "TeamStandingsController1")
                let passportTip2 = Storyboard.main.instantiate(viewController: "TeamStandingsController2")
                return [passportTip1, passportTip2]
            }
        }
    }
    var helpType:HelpType?
    var pageViewControllers:[UIViewController]?
}

extension StandingVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        pageViewControllers = helpType?.viewControllers
        guard let pageViewControllers = pageViewControllers else { fatalError("No view controllers defined for help type \(String(describing: helpType))") }
        DispatchQueue.main.async{
            self.setViewControllers([pageViewControllers[0]], direction: .forward, animated: false, completion: nil)
            self.configurePageControl()
        }
    }
    func configurePageControl() {
        
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = 2
        self.pageControl.currentPage = 0
        self.pageControl.alpha = 1
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
  
}

extension StandingVC: UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllers = pageViewControllers, let index = viewControllers.index(of: viewController), index > 0 else { return nil }
        return viewControllers[index - 1]
        
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllers = pageViewControllers, let index = viewControllers.index(of: viewController), index < viewControllers.count - 1  else { return nil }
        return viewControllers[index + 1]
    }
    
}
