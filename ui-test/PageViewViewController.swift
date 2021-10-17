//
//  PageViewViewController.swift
//  ui-test
//
//  Created by Mavin Sao on 17/10/21.
//

import UIKit

class PageViewViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.delegate = self
        self.dataSource = self
   
        let aVC: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "aVC")
        let bVC: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "bVC")
        let cVC: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "cVC")
        
        pages.append(aVC)
        pages.append(bVC)
        pages.append(cVC)
        
        self.setViewControllers([aVC], direction: .forward, animated: true, completion: nil)
        
        
        
    }
}

extension PageViewViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let cur = pages.firstIndex(of: viewController)!
    
        var prev = (cur - 1) % pages.count

        if prev < 0 {
            prev = pages.count - 1
        }
        
        return pages[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
     
        let cur = pages.firstIndex(of: viewController)!
        var nxt = (cur + 1)
        
        if nxt > pages.count - 1{
            nxt = 0
        }

        return pages[nxt]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    
}
