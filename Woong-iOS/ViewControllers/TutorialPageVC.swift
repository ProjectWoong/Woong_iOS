//
//  TutorialPageVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class TutorialPageVC: UIPageViewController , UIPageViewControllerDataSource{
    
    var pageController : UIPageViewController?
    var contentArray: [UIViewController] = [UIViewController]()
  
    
    private(set) lazy var orderedVCs: [UIViewController] = {
        return [self.newColoredViewController(id: "Tutorial1"),
                self.newColoredViewController(id:"Tutorial2"),
                self.newColoredViewController(id:"Tutorial3")]
    }()
    
    private func newColoredViewController(id: String) -> UIViewController {
        return UIStoryboard(name: "Tutorial", bundle: nil).instantiateViewController(withIdentifier: "\(id)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = orderedVCs.first {
            print("d")
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedVCs.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedVCs.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedVCs[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedVCs.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedVCs.count > previousIndex else {
            return nil
        }
        
        return orderedVCs[previousIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedVCs.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let viewController =  viewControllers?.first, let viewControllerIndex = orderedVCs.index(of: viewController) else {
            return 0
        }
        
        return viewControllerIndex
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }

}
