//
//  pageViewController_tong.swift
//  SakaiTVHW6
//
//  Created by tong on 10/20/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit

class pageViewController_tong: UIPageViewController, UIPageViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let firstViewController = viewarray.first {
            setViewControllers(
                [firstViewController],
                direction: .forward,
                animated: true,
                completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewarray.index(of: viewController) else {
            //            print("aaaaaaa")
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            //            ("bbbbb")print
            return nil
        }
        
        guard viewarray.count > previousIndex else {
            
            return nil
        }
        
        return viewarray[previousIndex]
    }
    //        return nil
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //        return nil
        guard let viewControllerIndex = viewarray.index(of: viewController) else {
            
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = viewarray.count
        
        guard orderedViewControllersCount != nextIndex else {
            
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            
            return nil
        }
        
        return viewarray[nextIndex]
    }
    
    private(set) lazy var viewarray: [UIViewController] = {
        
        return [self.viewtoflip(id: "info"),
                self.viewtoflip(id: "animation")]
    }()
    
    private func viewtoflip(id: String) -> UIViewController {
        
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(id)view")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
