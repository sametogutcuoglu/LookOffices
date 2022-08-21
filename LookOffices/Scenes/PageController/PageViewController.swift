//
//  PageViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 19.08.2022.
//

import UIKit

class PageViewController: UIPageViewController {

    var vcs = [UIViewController]()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        let tabbarStoryboard = UIStoryboard(name: "ListOffices", bundle: nil)
        let tabbarController : TabbarController = tabbarStoryboard.instantiateViewController(identifier: "TabbarController")
        let mapViewStoryboard = UIStoryboard(name: "OfficesMapView", bundle: nil)
        let mapViewController : OfficesMapViewViewController = mapViewStoryboard.instantiateViewController(identifier: "officeMapVC")
        vcs = [tabbarController,mapViewController]
        delegate = self
        dataSource = self
        
        if let firstVC = vcs.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource , UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == vcs.last{
            return vcs.first
        } else if viewController == vcs.first{
            return nil
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController == vcs.first{
            return vcs.last
        } else if viewController == vcs.last{
            return nil
        } else {
            return nil
        }
    }
}
