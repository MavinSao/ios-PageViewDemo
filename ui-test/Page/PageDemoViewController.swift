//
//  PageDemoViewController.swift
//  ui-test
//
//  Created by Mavin Sao on 17/10/21.
//

import UIKit

class PageDemoViewController: UIViewController {
    
    lazy var pageView : UIPageViewController = {
        return UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    }()
    
    @IBOutlet weak var pageControll: UIPageControl!
    
    
    var pages: [UIViewController] = []
    
    private var pendingIndex: Int?
    private var curentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageView.delegate   = self
        pageView.dataSource = self
        config()
        self.view.addSubview(pageView.view)
        self.view.bringSubviewToFront(pageControll)
        pageControll.numberOfPages = pages.count
        pageControll.currentPage = 0
    }
    
    @IBAction func onPageChange(_ sender: UIPageControl) {
        print(sender.currentPage)
        
        pageView.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        
    }
    
    
    func config(){
        
        let pageA: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "aVC")
        let pageB: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "bVC")
        let pageC: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "cVC")
        pages.append(pageA)
        pages.append(pageB)
        pages.append(pageC)
        
        pageView.setViewControllers([pageA], direction: .forward, animated: true, completion: nil)
        
    }

}

extension PageDemoViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    //set value to pageControll
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            curentIndex = pendingIndex
            if let curentIndex = curentIndex {
                pageControll.currentPage = curentIndex
            }
        }
    }
    
    //get the next coming index
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = pages.firstIndex(of: pendingViewControllers.first!)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //get current index
        let cIndex = pages.firstIndex(of: viewController)!
        
        //find prev index
        var prev = cIndex - 1
        if prev < 0 {
            prev = pages.count - 1
        }
        return pages[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //get current index
        let cIndex = pages.firstIndex(of: viewController)!
        
        //find next index
        let nxt = (cIndex + 1) % pages.count
        return pages[nxt]
    }
    
    
}
