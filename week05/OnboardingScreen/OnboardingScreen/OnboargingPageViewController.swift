//
//  OnboargingPageViewController.swift
//  OnboardingScreen
//
//  Created by Hümeyra Şahin on 6.02.2022.
//

import UIKit

class OnboargingPageViewController: UIPageViewController {

    var controllers = [OnboardingViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        let vc1 = makeController(imageName: "firstPage",
                                 titleLabel: "Welcome!",
                                 detailLabel: "Are you ready to learn Korean with us?")
        vc1.view.tag = 1
        controllers.append(vc1)
        
        let vc2 = makeController(imageName: "secondPage",
                                 titleLabel: "Make Friends!",
                                 detailLabel: "You can make native speaker friends and ask any question to them! Learn by using language!")
        vc2.view.tag = 2
        controllers.append(vc2)
        
        let vc3 = makeController(imageName: "thirdPage",
                                 titleLabel: "Get Certificate!",
                                 detailLabel: "Did you know that you can get a certificate for FREE?!")
        vc3.view.tag = 3
        vc3.goButton.isHidden = false
        controllers.append(vc3)
        
       
        self.view.addSubview(pageControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let first = controllers.first else { return }
        modalPresentationStyle = .fullScreen
        pageControl.currentPage = currentPageIndex
        setViewControllers([first], direction: .forward, animated: true, completion: nil)
    }
    
    var currentPageIndex = 1

    private lazy var pageControl: UIPageControl = {
        let pageControlWidth: CGFloat = 200
        let pageControlHeight: CGFloat = 100

        let frame = CGRect(x: (UIScreen.main.bounds.width - pageControlWidth) / 2,
                           y: UIScreen.main.bounds.height - 100,
                           width: pageControlWidth,
                           height: pageControlHeight)

        let pageControl = UIPageControl(frame: frame)
        pageControl.numberOfPages = controllers.count
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        return pageControl
    }()

    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        let index = sender.currentPage
        let direction: UIPageViewController.NavigationDirection = currentPageIndex > index ? .reverse : .forward
        currentPageIndex = index
        setViewControllers([controllers[index]], direction: direction, animated: true, completion: nil)
    }
    
}


func makeController(imageName: String, titleLabel: String, detailLabel: String) -> OnboardingViewController{
    let vc = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
    _ = vc.view
    vc.imageView.image = UIImage(named: imageName)
    vc.titleLabel.text = titleLabel
    vc.detailLabel.text = detailLabel
    return vc
}

//MARK: Delegate
extension OnboargingPageViewController: UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        guard let index = pageViewController.viewControllers?.first?.view.tag else { return }
        self.pageControl.currentPage = index
    }
    
}

//MARK: Data Source
extension OnboargingPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController as! OnboardingViewController), index > 0 else { return nil }
        let previous = index - 1
        return controllers[previous]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController as! OnboardingViewController), index < (controllers.count - 1) else { return nil }
        let next = index + 1
        return controllers[next]
    }
    
    
}
