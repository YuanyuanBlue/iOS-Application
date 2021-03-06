//
//  PageViewController.swift
//  ECE564_HOMEWORK
//
//  Created by yuyuanyuan on 9/29/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //the Bool is used to determine how many pages to show.
    //If a person's animation exists, it will show 2 pages, one for info view,
    //another for the animation view. Otherwise, it will only show 1 page for
    //the info view.
    var isYYY: Bool = false
    var isTong: Bool = false
    var isXin: Bool = false
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.index(of: viewController) ?? 0
        if(currentIndex <= 0) {
            return nil
        }
        return subViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.index(of: viewController) ?? 0
        if(currentIndex >= subViewControllers.count - 1) {
            return nil
        }
        return subViewControllers[currentIndex + 1]
    }
    
    //This function decides what pages should be displayed
    lazy var subViewControllers:[UIViewController] = {
        if(isYYY) {
            return [
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nv1") as! nv1,
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnimationViewController") as! AnimationViewController
            ]
        } else if(isTong) {
            return [
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nv1") as! nv1,
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hobbyViewController") as! hobbyViewController
            ]
        } else if(isXin) {
            return [
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nv1") as! nv1,
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SwimmingViewController") as! SwimmingViewController
            ]
        } else {
            return [
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nv1") as! nv1
            ]
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
